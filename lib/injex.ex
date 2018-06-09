defmodule Injex do
  defmacro inject(name, dep) do
    injex(name, dep, Mix.env())
  end

  defp injex(name, dep, :test) do
    quote do
      def unquote(name)() do
        Application.get_env(__MODULE__, unquote(name), unquote(dep))
      end
    end
  end

  defp injex(name, dep, _) do
    quote do
      @__injex_dep__ unquote(dep)
      defmacro unquote(name)() do
        quote do: unquote(@__injex_dep__)
      end
    end
  end
end
