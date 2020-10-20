# Predicator

Predicator is a safe (does not eval code), user facing boolean predicate engine.

It turns a string like `"score > 600 or income > 9000"` along with a supplied context into a `true` or `false`.

This predicate can be stored as an attribute of a model (ex: an Offer model could store a predicate indicating if it is available to a customer).

## Usage

### Compilation

The source code can be compiled down to list of instructions.

```elixir
Predicator.compile "score > 600 or income > 9000"

# [
#   ["load", "score"],
#   ["lit", 600],
#   ["compare", "GT"],
#   ["jtrue", 4],
#   ["load", "income"],
#   ["lit", 9000],
#   ["compare", "GT"]
# ]
```

### Evaluating

These instructions can be executed with a Predicator Evaluator in any available language (currently Elixir, and Ruby with others in progress).

```elixir
Predicator.compile!("score > 600 or income > 9000") |> Predicator.evaluate_instructions!(
  %{"score" => 590, "income" => "6000"}
)
# false

Predicator.compile!("score > 600 or income > 9000")
|> Predicator.evaluate_instructions!(%{"score" => 590, "income" => 9500})
# true
```

It is also possible to combine these steps:

```elixir
Predicator.evaluate!("score > 600 or income > 9000", %{"score" => 590})
# false

Predicator.evaluate!("score > 600 or income > 9000", %{"score" => 590, "income" => 9500})
# true
```

## Installation

The package can be installed by:

1. Adding to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:predicator, "~> 0.9"}]
  end
  ```

  or if you want to use the ecto types for predicator you can add the predicator_ecto lib.

  ```elixir
  def deps do
    [
      {:predicator, "~> 0.9"},
      {:predicator_ecto, ">= 0.0.0"},
    ]
  end
  ```

### TODO:

- [ ] Lex and parse parens
- [ ] Lex and parse `date`, `duration`, `ago`, `fromnow`
