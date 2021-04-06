defmodule Injex.Test do
  defmacro override(module, overrides, do: block) do
    quote do
      originals = injex_override_dependencies(unquote(module), unquote(overrides))

      unquote(block)

      injex_restore_dependencies(unquote(module), originals)
    end
  end

  def injex_override_dependencies(module, deps) do
    Enum.map(deps, fn {name, override} ->
      original = apply(module, name, [])

      Application.put_env(module, name, override)

      {name, original}
    end)
  end

  def injex_restore_dependencies(module, deps) do
    Enum.each(deps, fn {name, dep} ->
      Application.put_env(module, name, dep)
    end)
  end
end
