defmodule PCAPredict.AddressValidationTest do
  use ExUnit.Case
  doctest PCAPredict

  alias PCAPredict.Support.CaptureJsonResponse

  setup do
    bypass = PCAPredict.Support.Bypass.setup_and_open
    {:ok, bypass: bypass}
  end

  test "request with a valid postcode returns a valid response", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert "/Capture/Interactive/Find/v1.00/json3ex.ws" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, CaptureJsonResponse.find_response_with_postcode_objects)
    end
    {:ok, json} = PCAPredict.AddressValidation.lookup("WR2 6NJ")
    assert json |> Enum.count == 2
  end

  test "request with an invalid key returns an error object", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert "/Capture/Interactive/Find/v1.00/json3ex.ws" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, CaptureJsonResponse.invalid_key_response)
    end
    {:error, error, _resolution} = PCAPredict.AddressValidation.lookup("")
    assert error == "Unknown key"
  end

  test "request to an invalid postcode returns a error response", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert "/Capture/Interactive/Find/v1.00/json3ex.ws" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, CaptureJsonResponse.invalid_text_response)
    end
    {:error, error, _resolution} = PCAPredict.AddressValidation.lookup("")
    assert error == "Text or Container Required"
  end

  test "request will handle PCA Predict being down", %{bypass: bypass} do
    Bypass.down(bypass)

    {:error, error, _resolution} = PCAPredict.AddressValidation.lookup("")
    assert error == :econnrefused
  end
end
