defmodule Mctj.WeatherFetcherTest do
  use Mctj.DataCase

  describe "weather_fetcher" do
    alias Mctj.WeatherFetcher.Weather

    #need to make a factory to test this out properly
    
    test "parse 200 response",
      do: assert(Map.has_key?(Weather.fetch_current_weather("19460"), "location") == true)

    test "parse 404 response",
      do: assert(Map.has_key?(Weather.fetch_current_weather("194a60"), "message") == true)
  end
end

# mix test test/mctj/weather_fetcher_text.exs
