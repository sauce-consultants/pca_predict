defmodule PCAPredict.GeocodeItem do
  @moduledoc """
  Struct for items returned from the API

  The type is either `Address` or `Postcode`
  """

  defstruct [:accuracy, :easting, :northing,
             :latitude, :longitude, :location,
  :os_grid]
  use ExConstructor
end
