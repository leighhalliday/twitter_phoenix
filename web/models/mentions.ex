defmodule TwitterPhoenix.Mentions do

  alias TwitterPhoenix.Repo
  alias TwitterPhoenix.User
  alias TwitterPhoenix.Notification

  def notify_async(tweet) do
    Task.async(fn -> notify(tweet) end)
  end

  def notify(tweet) do
    Regex.scan(~r/(\@\w+)/, tweet.body)
     |> Enum.map(fn [username | _tail] -> String.downcase(username) end)
     |> Enum.uniq
     |> Enum.each(fn username -> notify_by_username(username, tweet) end)
  end

  defp notify_by_username("@"<>username, tweet) do
    notify_by_username(username, tweet)
  end
  defp notify_by_username(username, tweet) do
    Repo.get_by(User, username: username)
      |> notify_user(tweet)
  end

  defp notify_user(nil, _), do: nil
  defp notify_user(user, tweet) do
    unless user.id == tweet.user_id do
      notification = %Notification{
        user_id:           user.id,
        tweet_id:          tweet.id,
        ref_user_id:       tweet.user_id,
        notification_type: "mention"
      }
      Repo.insert!(notification)
    end
  end

end