defmodule TwitterPhoenix.TweetController do
  use TwitterPhoenix.Web, :controller

  alias TwitterPhoenix.{Tweet, User, UserTweets}

  plug :load_user
  plug :scrub_params, "tweet" when action in [:create, :update]

  def index(conn, _params) do
    tweets = UserTweets.latest(conn.assigns[:user])
    render(conn, "index.html", tweets: tweets)
  end

  def new(conn, _params) do
    changeset = Tweet.changeset(%Tweet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tweet" => tweet_params}) do
    changeset =
      Ecto.build_assoc(conn.assigns[:user], :tweets, %{like_count: 0, retweet_count: 0})
      |> Tweet.changeset(tweet_params)

    case Repo.insert(changeset) do
      {:ok, tweet} ->

        TwitterPhoenix.Mentions.notify_async(tweet)

        conn
        |> put_flash(:info, "Tweet created successfully.")
        |> redirect(to: user_tweet_path(conn, :index, conn.assigns[:user].username))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tweet = Repo.get!(Tweet, id)
    render(conn, "show.html", tweet: tweet)
  end

  def edit(conn, %{"id" => id}) do
    tweet = Repo.get!(Tweet, id)
    changeset = Tweet.changeset(tweet)
    render(conn, "edit.html", tweet: tweet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tweet" => tweet_params}) do
    tweet = Repo.get!(Tweet, id)
    changeset = Tweet.changeset(tweet, tweet_params)

    case Repo.update(changeset) do
      {:ok, tweet} ->
        conn
        |> put_flash(:info, "Tweet updated successfully.")
        |> redirect(to: user_tweet_path(conn, :show, conn.assigns[:user].username, tweet))
      {:error, changeset} ->
        render(conn, "edit.html", tweet: tweet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tweet = Repo.get!(Tweet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tweet)

    conn
    |> put_flash(:info, "Tweet deleted successfully.")
    |> redirect(to: user_tweet_path(conn, :index, conn.assigns[:user].username))
  end

  defp load_user(conn, _) do
    user = Repo.get_by!(User, username: conn.params["user_id"])
    assign(conn, :user, user)
  end
end
