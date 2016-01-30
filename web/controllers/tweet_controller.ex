defmodule TwitterPhoenix.TweetController do
  use TwitterPhoenix.Web, :controller

  alias TwitterPhoenix.Tweet

  plug :scrub_params, "tweet" when action in [:create, :update]

  def index(conn, _params) do
    tweets = Repo.all(Tweet)
    render(conn, "index.html", tweets: tweets)
  end

  def new(conn, _params) do
    changeset = Tweet.changeset(%Tweet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tweet" => tweet_params}) do
    changeset = Tweet.changeset(%Tweet{}, tweet_params)

    case Repo.insert(changeset) do
      {:ok, tweet} ->

        

        conn
        |> put_flash(:info, "Tweet created successfully.")
        |> redirect(to: tweet_path(conn, :index))
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
        |> redirect(to: tweet_path(conn, :show, tweet))
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
    |> redirect(to: tweet_path(conn, :index))
  end
end
