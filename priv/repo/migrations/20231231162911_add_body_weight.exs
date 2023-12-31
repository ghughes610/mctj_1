defmodule Mctj.Repo.Migrations.AddBodyWeight do
  use Ecto.Migration
  def change do
    alter table(:workouts) do
      add :body_weight, :integer
    end
  end
end
