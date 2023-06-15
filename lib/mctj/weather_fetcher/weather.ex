defmodule Mctj.WeatherFetcher.Weather do
  def fetch_current_weather(zip) do
    url =
      "https://api.openweathermap.org/data/2.5/weather?zip=#{zip},US&appid=#{@api_key}&units=imperial"

    HTTPoison.get!(url).body
    |> JSON.decode!()
    |> parse_response()
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
