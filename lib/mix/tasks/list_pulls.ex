defmodule Mix.Tasks.ListPulls do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    GhPullsPing.Repo.Core.list_pulls()
    |> IO.inspect()
  end
end
