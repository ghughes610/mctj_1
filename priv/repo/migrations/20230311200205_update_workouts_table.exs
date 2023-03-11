defmodule Mctj.Repo.Migrations.UpdateWorkoutsTable do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :metadata, :map, default: %{}
    end
  end
end
