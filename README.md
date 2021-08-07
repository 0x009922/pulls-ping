# GhPing

## Usage design

Firstly, config is required. It have to contain telegram bot token, telegram user token and github token.

GitHub review data looks like this:

```json
{
  "id": 80,
  "node_id": "MDE3OlB1bGxSZXF1ZXN0UmV2aWV3ODA=",
  "user": {
    "login": "octocat",
    "id": 1,
    "node_id": "MDQ6VXNlcjE=",
    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
    "gravatar_id": "",
    "url": "https://api.github.com/users/octocat",
    "html_url": "https://github.com/octocat",
    "followers_url": "https://api.github.com/users/octocat/followers",
    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
    "organizations_url": "https://api.github.com/users/octocat/orgs",
    "repos_url": "https://api.github.com/users/octocat/repos",
    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
    "received_events_url": "https://api.github.com/users/octocat/received_events",
    "type": "User",
    "site_admin": false
  },
  "body": "Here is the body for the review.",
  "state": "APPROVED",
  "html_url": "https://github.com/octocat/Hello-World/pull/12#pullrequestreview-80",
  "pull_request_url": "https://api.github.com/repos/octocat/Hello-World/pulls/12",
  "_links": {
    "html": {
      "href": "https://github.com/octocat/Hello-World/pull/12#pullrequestreview-80"
    },
    "pull_request": {
      "href": "https://api.github.com/repos/octocat/Hello-World/pulls/12"
    }
  }, 
  "submitted_at": "2019-11-17T17:43:43Z",
  "commit_id": "ecdd80bb57125d7ba9641ffaa4d7d2c19d3f3091",
  "author_association": "COLLABORATOR"
}
```

So, what should be stored? Firstly, the list of watching pulls. Secondly, for each of PR it should store the list of PRs and their **last reported to telegram state**. If after another gh poll state is changed (which is determined thanks to stored data), than the report is being made.

So, there will be 2 storage files - `pulls.yaml` and `pulls-reports.yaml`.

```yaml
# pulls.yaml
- https://github.com/octocat/Hello-World/pull/12
- https://github.com/octocat/Hello-World/pull/14
```

```yaml
# pulls-reports.yaml

# keys - pull requests
https://github.com/octocat/Hello-World/pull/12:
  # keys - id of reviews
  80:
    # last reported state for this review
    state: "APPROVED"
```

Rule: **When PR is closed, it is being removed from pulls list.**

Let's experiment and see, how it works! Will it work at general?

## Modules

- `Telegram` - application service that sends and receives messages to and from telegram
  - `MessageRenderer` - renders any messages to telegram user
  - `Sender` - sends data to telegram in different ways
  - `Core` - makes different decisions about what to do in Telegram module
  - `Poller` - polls telegram for incoming instructions
- `Repo` - service to store and retrieved stored information
- `Octocat` - service that polls GitHub and retrieving state of PRs that are in list of interest
  - `Poller` - polls GitHub for updates in PRs
  - `Core` - makes all singificant GitHub-related decisions
- `Logger` - main entrypoint to any logging?

## Supervision tree



