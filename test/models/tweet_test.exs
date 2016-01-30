defmodule TwitterPhoenix.TweetTest do
  use TwitterPhoenix.ModelCase

  alias TwitterPhoenix.Tweet

  @valid_attrs %{body: "some content", like_count: 42, retweet_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tweet.changeset(%Tweet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tweet.changeset(%Tweet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
