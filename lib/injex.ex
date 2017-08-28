defmodule Injex do
  if Mix.env == :test do

    defmacro inject(name, dep) do
      quote do
        def unquote(name)() do
          Application.get_env(__MODULE__, unquote(name), unquote(dep))
        end
      end
    end

  else

    defmacro inject(name, dep) do
      quote do
        def unquote(name)() do
          unquote(dep)
        end
      end
    end

  end
end
