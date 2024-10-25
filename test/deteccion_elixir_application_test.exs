defmodule DeteccionElixir.ApplicationTest do
  use ExUnit.Case
  doctest DeteccionElixir.Application
  alias DeteccionElixir.Config.AppConfig

  test "test childrens" do
    assert DeteccionElixir.Application.env_children(:test, %AppConfig{}) == []
  end
end
