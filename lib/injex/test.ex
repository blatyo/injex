defmodule Injex.Test do
  defmacro override(module, overrides, do: block) do
    quote do
      originals = injex_original_dependencies(unquote(module), unquote(overrides))
      injex_override_dependencies(unquote(module), unquote(overrides))

      unquote(block)

      injex_override_dependencies(unquote(module), originals)
    end
  end

  def injex_original_dependencies(module, deps) do
    deps
    |> Enum.map(fn({name, _}) ->
      {name, apply(module, name, [])}
    end)
  end

  def injex_override_dependencies(module, deps) do
    deps
    |> Enum.each(fn({name, dep}) ->
      Application.put_env(module, name, dep)
    end)
  end
end
