defmodule TwitterPhoenix.TweetControllerTest do
  use TwitterPhoenix.ConnCase

  alias TwitterPhoenix.Tweet
  @valid_attrs %{body: "some content", like_count: 42, retweet_count: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tweet_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tweets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tweet_path(conn, :new)
    assert html_response(conn, 200) =~ "New tweet"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tweet_path(conn, :create), tweet: @valid_attrs
    assert redirected_to(conn) == tweet_path(conn, :index)
    assert Repo.get_by(Tweet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tweet_path(conn, :create), tweet: @invalid_attrs
    assert html_response(conn, 200) =~ "New tweet"
  end

  test "shows chosen resource", %{conn: conn} do
    tweet = Repo.insert! %Tweet{}
    conn = get conn, tweet_path(conn, :show, tweet)
    assert html_response(conn, 200) =~ "Show tweet"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, tweet_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tweet = Repo.insert! %Tweet{}
    conn = get conn, tweet_path(conn, :edit, tweet)
    assert html_response(conn, 200) =~ "Edit tweet"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tweet = Repo.insert! %Tweet{}
    conn = put conn, tweet_path(conn, :update, tweet), tweet: @valid_attrs
    assert redirected_to(conn) == tweet_path(conn, :show, tweet)
    assert Repo.get_by(Tweet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tweet = Repo.insert! %Tweet{}
    conn = put conn, tweet_path(conn, :update, tweet), tweet: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tweet"
  end

  test "deletes chosen resource", %{conn: conn} do
    tweet = Repo.insert! %Tweet{}
    conn = delete conn, tweet_path(conn, :delete, tweet)
    assert redirected_to(conn) == tweet_path(conn, :index)
    refute Repo.get(Tweet, tweet.id)
  end
end
