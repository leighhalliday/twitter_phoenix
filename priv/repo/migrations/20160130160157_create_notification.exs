defmodule TwitterPhoenix.Repo.Migrations.CreateNotification do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :read_at, :datetime
      add :notification_type, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :ref_user_id, references(:users, on_delete: :nothing)
      add :tweet_id, references(:tweets, on_delete: :nothing)

      timestamps
    end
    create index(:notifications, [:user_id])
    create index(:notifications, [:ref_user_id])
    create index(:notifications, [:tweet_id])

  end
end
