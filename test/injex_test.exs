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
      assert Injectable.one() == InjexTest.One
    end
  end

  describe "override/2" do
    test "overrides dependencies for scope of the block" do
      assert Injectable.one() == InjexTest.One

      override Injectable, one: InjexTest.Uno do
        assert Injectable.one() == InjexTest.Uno
      end

      assert Injectable.one() == InjexTest.One
    end
  end
end
