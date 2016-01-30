defmodule TwitterPhoenix.Repo.Migrations.CreateTweet do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :body, :string
      add :retweet_count, :integer
      add :like_count, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:tweets, [:user_id])

  end
end
