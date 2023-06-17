defmodule Mctj.ApplicationConfigs. ApplicationConfig do
  use Ecto.Schema
  import Ecto.Changeset

  schema "application_config" do
    field :api_key, :string, redact: true
    field :service_name, :string
    field :service_url, :string
    field :metadata, :map

    timestamps()
  end

  @doc false
  def changeset(application_config, attrs) do
    application_config
    |> cast(attrs, [:api_key, :service_name, :service_url, :metadata])
    |> validate_required([:api_key, :service_name, :service_url, :metadata])
  end
end
