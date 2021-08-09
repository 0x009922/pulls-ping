defmodule GhPullsPingOctocatCoreTest do
  use ExUnit.Case
  alias GhPullsPing.Octocat.Core

  test "Extracts owner, repo and pull number from link correctly" do
    assert Core.parse_github_link("https://github.com/vuejs/vue-next/pull/4235") ==
             {:ok,
              %{
                owner: "vuejs",
                repo: "vue-next",
                pull_number: 4235
              }}
  end

  test "Fails on invalid link" do
    assert Core.parse_github_link("some-invalid-input") == {:error, :invalid_link}
  end
end
