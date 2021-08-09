defmodule GhPullsPingRepoCoreTest do
  use ExUnit.Case
  alias GhPullsPing.Repo.Core

  test "Parses dotenv with no entries correctly" do
    sample = ""

    assert Core.parse_dotenv(sample) == %{}
  end

  test "Parses dotenv with single entry correctly" do
    sample = """
    TOKEN=1234
    """

    assert Core.parse_dotenv(sample) == %{
             "TOKEN" => "1234"
           }
  end

  test "Parses dotenv with 3 entries correctly" do
    sample = ""

    assert Core.parse_dotenv(sample) == %{}
  end
end
