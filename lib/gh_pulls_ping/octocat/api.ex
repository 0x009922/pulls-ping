defmodule GhPullsPing.Octocat.Api do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.github.com")
  # plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug(Tesla.Middleware.JSON)

  def get_reviews(%{
        owner: owner,
        repo: repo,
        pull_number: pull_number
      }) do
    get("/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews")
  end

  # def fetch_pull_request_reviews(%{
  #       owner: owner,
  #       repo: repo,
  #       pull_number: pull_number
  #     }) do
  #   %Http.Response{
  #     status_code: 200,
  #     body: body
  #   } = Http.get!("/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews")

  #   {:ok, body}
  # end
end
