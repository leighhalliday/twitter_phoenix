defmodule TwitterPhoenix.TweetView do
  use TwitterPhoenix.Web, :view

  def username(conn) do
    conn.assigns[:user].username
  end
end
