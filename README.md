# Injex

A simple way to describe dependencies that can be replaced at test time.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `injex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:injex, "~> 0.1.0"}]
    end
    ```

## Usage

In modules, instead of:

```elixir
defmodule MyModule do
  def process(data) do
    changeset = # ...

    Repo.insert(changeset)
  end
end
```

You write:

```elixir
defmodule MyModule do
  import Injex
  inject :repo, Repo

  def process(data) do
    changeset = # ...

    repo.insert(changeset)
  end
end
```

Then, in your tests, you can replace `Repo` with a different one to simplify testing.

```elixir
defmodule MyModuleTest do
  use ExUnit.Case
  import Injex.Test

  defmodule Repo do
    def insert(changeset), do: send(self, {:insert, changeset})
  end

  describe ".process" do
    test "inserts data" do
      override MyModule, repo: MyModuleTest.Repo do
        MyModule.process(%{})

        assert_received {:insert, changeset}
      end
    end
  end
end
```

The `inject` macro will only include overriding capabilities when `Mix.env` is `:test`. Otherwise, it hardcodes the default dependency.
