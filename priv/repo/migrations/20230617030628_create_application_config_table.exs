defmodule Mctj.Repo.Migrations.CreateApplicationConfigTable do
  use Ecto.Migration

  def change do
    create table(:application_config) do
      add :api_key, :string
      add :service_name, :string
      add :service_url, :string
      add :metadata, :map, default: %{}

      timestamps()
    end
  end
end
