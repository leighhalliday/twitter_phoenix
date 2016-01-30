defmodule TwitterPhoenix.NotificationTest do
  use TwitterPhoenix.ModelCase

  alias TwitterPhoenix.Notification

  @valid_attrs %{notification_type: "some content", read_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Notification.changeset(%Notification{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Notification.changeset(%Notification{}, @invalid_attrs)
    refute changeset.valid?
  end
end
