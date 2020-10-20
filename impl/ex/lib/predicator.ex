defmodule Predicator do
  @moduledoc """
  Documentation for Predicator.

  Lexer and Parser currently compatible with 1.1.0 predicate syntax
  """
  alias Predicator.Evaluator

  @lexer :predicate_lexer
  @atom_parser :atom_instruction_parser
  @string_parser :string_instruction_parser

  # ---------------------------------------------------------------------------
  # Types

  @type token_key_t ::
          :atom_key_inst
          | :string_key_inst

  @type predicate :: String.t() | charlist

  @typedoc """
  The source code of the predicate.
  This will be lexed, parsed and compiled into an array of instructions which can
  be evaluated by a `Predicator.Evaluator`.
  """
  @type source :: String.t()

  @typedoc """
  The data provided to predicates as they are evaluated.
  """
  @type context :: Map.t()

  @typedoc """
  A list of instructions.
  Each instruction in encoded as a list. This is a list of these lists which can be
  evaluated by a `Predicator.Evaluator`.
  """
  @type instructions :: list(list())

  @type error :: {:error, String.t()}

  # ---------------------------------------------------------------------------
  # Public API

  @spec compile(source :: source()) :: {:ok, instructions()} | error()
  @doc """
  Compiles the `source` string into a list of instructions.

  These instructions can be evaluated by a `Predicator.Evaluator`.

  ### Examples
      iex> Predicator.compile "score > 600 or income > 9000"
      {:ok,
       [
         ["load", "score"],
         ["lit", 600],
         ["compare", "GT"],
         ["jtrue", 4],
         ["load", "income"],
         ["lit", 9000],
         ["compare", "GT"]
       ]}
  """
  def compile(source, token_type \\ :string_key_inst) do
    with {:ok, tokens, _} <- leex_string(source),
         {:ok, instructions} <- parse_lexed(tokens, token_type) do
      {:ok, instructions}
    else
      {:error, _} = err -> err
      {:error, left, right} -> {:error, {left, right}}
    end
  end

  @doc """
  leex_string/1 takes string or charlist and returns a lexed tuple for parsing.

  iex> leex_string('10 > 5')
  {:ok, [{:lit, 1, 10}, {:compare, 1, :GT}, {:lit, 1, 5}], 1}

  iex> leex_string("apple > 5532")
  {:ok, [{:load, 1, :apple}, {:compare, 1, :GT}, {:lit, 1, 5532}], 1}
  """
  @spec leex_string(predicate) :: {:ok | :error, list | tuple, non_neg_integer()}
  def leex_string(str) when is_binary(str), do: str |> to_charlist |> leex_string
  def leex_string(str) when is_list(str), do: @lexer.string(str)

  @doc """
  parse_lexed/1 takes a leexed token(list or tup) and returns a predicate. It also
  can take optional atom for type of token keys to return. options are `:string_ey_inst` & `:atom_key_inst`

      iex> parse_lexed({:ok, [{:load, 1, :apple}, {:compare, 1, :GT}, {:lit, 1, 5532}], 1})
      {:ok, [["load", "apple"], ["lit", 5532], ["compare", "GT"]]}

      iex> parse_lexed({:ok, [{:load, 1, :apple}, {:compare, 1, :GT}, {:lit, 1, 5532}], 1}, :string_key_inst)
      {:ok, [["load", "apple"], ["lit", 5532], ["compare", "GT"]]}

      iex> parse_lexed([{:load, 1, :apple}, {:compare, 1, :GT}, {:lit, 1, 5532}], :atom_key_inst)
      {:ok, [[:load, :apple], [:lit, 5532], [:compare, :GT]]}
  """
  @spec parse_lexed(list, token_key_t) :: {:ok | :error, list | tuple}
  def parse_lexed(token, opt \\ :string_key_inst)
  def parse_lexed(token, :string_key_inst) when is_list(token), do: @string_parser.parse(token)
  def parse_lexed({_, token, _}, :string_key_inst), do: @string_parser.parse(token)

  def parse_lexed(token, :atom_key_inst) when is_list(token), do: @atom_parser.parse(token)
  def parse_lexed({_, token, _}, :atom_key_inst), do: @atom_parser.parse(token)

  @doc """
  leex_and_parse/1 takes a string or charlist and does all lexing and parsing then
  returns the predicate.

  iex> leex_and_parse("13 > 12")
  [["lit", 13], ["lit", 12], ["compare", "GT"]]

  iex> leex_and_parse('532 == 532', :atom_key_inst)
  [[:lit, 532], [:lit, 532], [:compare, :EQ]]
  """
  @spec leex_and_parse(String.t()) :: list | {:error, any(), non_neg_integer}
  def leex_and_parse(str, token_type \\ :string_key_inst) do
    with {:ok, tokens, _} <- leex_string(str),
         {:ok, predicate} <- parse_lexed(tokens, token_type) do
      predicate
    end
  end

  @doc """
  Takes a predicate set, a context struct and options.

  Eval options:
  * `map_type`: type of keys for context map, `:atom` or `:string`. Defaults to `:string`.
  * `nil_values`: list of values considered "blank" for `isblank` comparison. Defaults to `["", nil]`.

  """
  def eval(inst, context \\ %{}, opts \\ [map_type: :string])
  def eval(inst, context, opts), do: Evaluator.execute(inst, context, opts)

  def matches?(predicate), do: matches?(predicate, [])

  def matches?(predicate, context) when is_list(context) do
    matches?(predicate, Map.new(context))
  end

  def matches?(predicate, context) when is_binary(predicate) or is_list(predicate) do
    with {:ok, predicate} <- compile(predicate) do
      eval(predicate, context)
    end
  end

  @doc """
  Takes in a predicate and context and returns the match result.
  Context can be either a list or map. Accepts same options as `eval/3`.

  ```
  iex> matches?("fruit in ['apple', 'pear']", %{"fruit" => "watermelon"}, [map_type: :string])
  false

  iex> matches?("fruit in ['apple', 'pear']", [fruit: "pear"], [map_type: :atom])
  true

  iex> matches?("fruit is blank", [fruit: nil], [map_type: :atom, nil_values: [nil]])
  true

  ```
  """
  def matches?(predicate, context, eval_opts) do
    with {:ok, predicate} <- compile(predicate) do
      eval(predicate, context, eval_opts)
    end
  end
end
