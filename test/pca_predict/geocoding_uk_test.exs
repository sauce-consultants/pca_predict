defmodule PCAPredict.GeocodingUKTest do
  use ExUnit.Case
  doctest PCAPredict

  alias PCAPredict.Support.GeocodingUKJsonResponse

  setup do
    bypass = PCAPredict.Support.Bypass.setup_and_open
    {:ok, bypass: bypass}
  end

  test "request with a valid postcode returns a valid response", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert "/Geocoding/UK/Geocode/v2.10/json3ex.ws" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, GeocodingUKJsonResponse.find_response_with_postcode_objects)
    end
    {:ok, json} = PCAPredict.GeocodingUK.lookup("WR2 6NJ")

    assert json == %{"Accuracy" => "Standard",
      "Easting" => "381676",
      "Latitude" => "52.2327",
      "Location" => "Moseley Road, Hallow, Worcester",
      "Longitude" => "-2.2697",
      "Northing" => "259425",
      "OsGrid" => "SO 81676 59425"}
  end

  test "request with an invalid key returns an error object", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert "/Geocoding/UK/Geocode/v2.10/json3ex.ws" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, GeocodingUKJsonResponse.invalid_key_response)
    end
    {:error, errors} = PCAPredict.GeocodingUK.lookup("")
    assert Enum.at(errors, 0).description == "Unknown key"
  end

  test "request to an invalid postcode returns a error response", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert "/Geocoding/UK/Geocode/v2.10/json3ex.ws" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, GeocodingUKJsonResponse.invalid_text_response)
    end
    {:error, errors} = PCAPredict.GeocodingUK.lookup("")
    assert Enum.at(errors, 0).description == "Text or Container Required"
  end

end
