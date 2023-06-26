defmodule Mctj.Repo.Migrations.CreateApiRequestTable do
  use Ecto.Migration

  def change do
    create table(:api_requests) do
      add :url, :string
      add :request_date, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :metadata, :map, default: %{}
    end
  end
end
