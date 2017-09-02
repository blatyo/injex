defmodule Injex do
  defmacro inject(name, dep) do
    if Mix.env == :test do
      quote do
        def unquote(name)(), do: Application.get_env(__MODULE__, unquote(name), unquote(dep))
      end
    else
      quote do
        def unquote(name)(), do: unquote(dep)
      end
    end
  end
end
