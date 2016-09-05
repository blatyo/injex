defmodule InjexTest do
  use ExUnit.Case
  import Injex.Test
  doctest Injex

  defmodule Injectable do
    import Injex
    inject :one, One
  end

  describe "inject" do
    test "generates a method that defaults the dependency" do
      assert Injectable.one == One
    end
  end

  describe "override" do
    test "overrides dependencies for scope of the block" do
      assert Injectable.one == One

      override Injectable, one: Uno do
        assert Injectable.one == Uno
      end

      assert Injectable.one == One
    end
  end
end
