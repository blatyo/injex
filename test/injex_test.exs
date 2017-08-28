defmodule InjexTest do
  use ExUnit.Case
  import Injex.Test
  doctest Injex

  defmodule One do
    def call, do: nil
  end

  defmodule Uno do
    def call, do: nil
  end

  defmodule Eins do
    def call(one), do: one
  end

  defmodule Injectable do
    import Injex
    inject :one, InjexTest.One
  end

  describe "inject/2" do
    test "generates a method that defaults the dependency" do
      assert Injectable.one == InjexTest.One
    end
  end

  describe "override/2" do
    test "overrides dependencies for scope of the block" do
      assert Injectable.one == InjexTest.One

      override Injectable, one: InjexTest.Uno do
        assert Injectable.one == InjexTest.Uno
      end

      assert Injectable.one == InjexTest.One
    end

    test "raises error when mock modules api is not a subset of original" do
      text = """
      Override failed for InjexTest.Injectable.one/0

        Override: InjexTest.Eins
        Original: InjexTest.One

      Override has the following function signatures that the original does
      not define:

        * call/1

      Usually, this means your override has diverged from the original's
      function signatures and needs to be updated. If that is not the case,
      then you should change the overrides additional functions to private.
      """
      assert_raise(Injex.Test.Error, text, fn ->
        override Injectable, one: InjexTest.Eins do
        end
      end)
    end
  end
end
