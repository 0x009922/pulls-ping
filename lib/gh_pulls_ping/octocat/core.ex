defmodule GhPullsPing.Octocat.Core do
  def parse_github_link(link) when is_binary(link) do
    case Regex.run(~r|^https://github.com/(.+?)/(.+?)/pull/(\d+)|, link) do
      [_whole, owner, repo, pull_number] ->
        {:ok,
         %{
           owner: owner,
           repo: repo,
           pull_number: String.to_integer(pull_number)
         }}

      _ ->
        {:error, :invalid_link}
    end
  end
end
