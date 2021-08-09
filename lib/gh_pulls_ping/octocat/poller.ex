defmodule GhPullsPing.Octocat.Poller do
  def child_spec(arg) do
    %{
      id: GhPullsPing.Octocat.Poller,
      start: {GhPullsPing.Octocat.Poller, :start_link, [arg]}
    }
  end

  def start_link(_arg) do
    pid =
      spawn_link(fn ->
        init()
      end)

    {:ok, pid}
  end

  defp init() do
    loop(%{
      poll_interval: 300_000
    })
  end

  defp loop(params) do
    do_poll()

    Process.sleep(params.poll_interval)
    loop(params)
  end

  defp do_poll() do
    # read pulls
    {:ok, pulls} = GhPullsPing.Repo.Service.list_pulls()

    # fetch state of each pull
    reviews =
      pulls
      |> Stream.map(&GhPullsPing.Octocat.Core.parse_github_link/1)
      |> Stream.map(fn {:ok, params} -> params end)
      |> Task.async_stream(fn params ->
        GhPullsPing.Octocat.Api.get_reviews(params)
      end)
      |> Enum.to_list()

    # print
    IO.inspect(reviews)
  end
end
