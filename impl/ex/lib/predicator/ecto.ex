if Code.ensure_loaded?(Ecto) do
  defmodule Ecto.PredicatorInstructions do
    @moduledoc """
    An Ecto type for Predicator insturctions.
    """

    use Ecto.Type

    @doc """
    The underlying schema type.
    """
    def type(), do: :jsonb

    def cast(data), do: {:ok, data}

    def load(data), do: {:ok, data}

    def dump(data), do: {:ok, data}
  end
end
