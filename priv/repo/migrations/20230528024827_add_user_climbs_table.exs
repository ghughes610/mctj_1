defmodule Mctj.Repo.Migrations.AddUserClimbsTable do
  use Ecto.Migration

  def change do
    create table(:user_climbs) do
      add :climb_id, references(:climbs, on_delete: :nothing)
      add :metadata, :map
      add :user_id, references(:users, on_delete: :delete_all)
      add :send_date, :date
      add :sessions, :integer

      timestamps()
    end
  end
end
