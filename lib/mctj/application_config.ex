defmodule Mctj.ApplicationConfig do

  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.ApplicationConfigs.ApplicationConfig

  def list_configs do
    Repo.all(ApplicationConfig)
  end

  def get_config!(id), do: Repo.get!(ApplicationConfig, id)

  def get_config_by_service_name!(service_name) do
    ApplicationConfig
    |> where(service_name: ^service_name)
    |> Repo.one()
  end

  def get_weather_service_config, do: get_config_by_service_name!("open_weather_map")

end
