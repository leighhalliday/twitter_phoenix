defmodule TwitterPhoenix.Tweet do
  use TwitterPhoenix.Web, :model

  schema "tweets" do
    field :body, :string
    field :retweet_count, :integer
    field :like_count, :integer
    belongs_to :user, TwitterPhoenix.User

    timestamps
  end

  @required_fields ~w(body retweet_count like_count)
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
