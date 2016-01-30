defmodule TwitterPhoenix.Notification do
  use TwitterPhoenix.Web, :model

  schema "notifications" do
    field :read_at, Ecto.DateTime
    field :notification_type, :string
    belongs_to :user, TwitterPhoenix.User
    belongs_to :ref_user, TwitterPhoenix.RefUser
    belongs_to :tweet, TwitterPhoenix.Tweet

    timestamps
  end

  @required_fields ~w(read_at notification_type)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
