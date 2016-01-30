ExUnit.start

Mix.Task.run "ecto.create", ~w(-r TwitterPhoenix.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r TwitterPhoenix.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(TwitterPhoenix.Repo)

