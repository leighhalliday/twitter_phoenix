defmodule TwitterPhoenix.User do
  use TwitterPhoenix.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :bio, :string

    timestamps
  end

  @required_fields ~w(name username email bio)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
