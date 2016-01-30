defmodule TwitterPhoenix.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string
      add :email, :string
      add :bio, :string

      timestamps
    end
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])

  end
end
