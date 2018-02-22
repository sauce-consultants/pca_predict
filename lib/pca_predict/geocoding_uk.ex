defmodule PCAPredict.GeocodingUK do
  @moduledoc """
  Geocoding UK Geocode (v1.00)

  Returns the OS easting + northing along with WGS84 latitude and longitude
  for the given postcode. Supports UK only.
  """

  @doc """
  The location to geocode. This can be a full or partial postcode,
  a place name, street comma town, address (comma separated lines) or
  an ID from PostcodeAnywhere/Find web services.
  """
  @spec lookup(String.t) :: {:ok, Map.t} | {:error, List.t}
  def lookup(location) do
    PCAPredict.Client.request("/Geocoding/UK/Geocode/v2.10/json3ex.ws",
                              %{Location: location})
    |> process_response()
  end

  defp process_response({:error, errors}), do:
    {:error, errors}
  defp process_response({:ok, data}) do
    location = Enum.at(data, 0)
    {:ok, location}
  end
end
