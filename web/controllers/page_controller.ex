defmodule TwitterPhoenix.PageController do
  use TwitterPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
