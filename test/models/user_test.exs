defmodule TwitterPhoenix.UserTest do
  use TwitterPhoenix.ModelCase

  alias TwitterPhoenix.User

  @valid_attrs %{bio: "some content", email: "some content", name: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
