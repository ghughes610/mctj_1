defmodule Mctj.WeatherFetcher.Weather do
  alias Mctj.ApplicationConfig

  def fetch_current_weather(zip) do
    HTTPoison.get!(generate_weather_url(zip)).body
    |> JSON.decode!()
    |> parse_response()
  end

  defp generate_weather_url(zip) do
    config = ApplicationConfig.get_weather_service_config()

    config.service_url
    |> String.replace("query_zip", zip)
    |> String.replace("api_key", config.api_key)
  end

  defp parse_response(%{
         "name" => name,
         "clouds" => clouds,
         "main" => %{"feels_like" => feels_like, "humidity" => humidity, "temp" => temp},
         "weather" => [%{"description" => description}],
         "wind" => %{"speed" => wind_speed}
       }) do
    %{
      "location" => name,
      "feels_like" => feels_like,
      "humidity" => humidity,
      "temp" => temp,
      "description" => description,
      "cloud_percentage" => clouds,
      "wind_speed" => wind_speed
    }
  end

  defp parse_response(%{"cod" => "404", "message" => message}), do: %{"message" => message}
  defp parse_response(result), do: result
end
