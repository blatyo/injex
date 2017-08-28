defmodule Injex.Test do
  defmodule Error do
    defexception [:message]
  end

  defmacro override(module, overrides, do: block) do
    quote do
      originals = injex_override_dependencies(unquote(module), unquote(overrides))

      unquote(block)

      injex_restore_dependencies(unquote(module), originals)
    end
  end

  def injex_override_dependencies(module, deps) do
    Enum.map(deps, fn({name, override}) ->
      original = apply(module, name, [])

      if is_module?(original) && is_module?(override) do
        validate_dep!(module, name, original, override)
      end
      Application.put_env(module, name, override)

      {name, original}
    end)
  end

  def injex_restore_dependencies(module, deps) do
    Enum.each(deps, fn({name, dep}) ->
      Application.put_env(module, name, dep)
    end)
  end

  defp is_module?(thing) do
    is_atom(thing) && :erlang.function_exported(thing, :module_info, 0)
  end

  defp validate_dep!(module, name, original, override) do
    original_funs = MapSet.new(original.__info__(:functions))
    override_funs = MapSet.new(override.__info__(:functions))
    unknown_funs = MapSet.difference(override_funs, original_funs)

    case Enum.count(unknown_funs) do
      0 -> true
      _ ->
        raise Error, """
        Override failed for #{inspect module}.#{name}/0

          Override: #{inspect override}
          Original: #{inspect original}

        Override has the following function signatures that the original does
        not define:

        #{for {fun, arity} <- unknown_funs, do: "  * #{fun}/#{arity}\n"}
        Usually, this means your override has diverged from the original's
        function signatures and needs to be updated. If that is not the case,
        then you should change the overrides additional functions to private.
        """
    end
  end
end
