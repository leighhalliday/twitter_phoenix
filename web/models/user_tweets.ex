defmodule TwitterPhoenix.UserTweets do
  import Ecto.Query
  alias TwitterPhoenix.{Repo, Tweet}

  def latest(user, count \\ 25) do
    Repo.all(
      from t in Tweet,
      where: t.user_id == ^user.id,
      limit: ^count,
      order_by: [desc: t.id]
    )
  end
end
