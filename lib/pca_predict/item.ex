defmodule PCAPredict.Item do
  @moduledoc """
  Struct for items returned from the API

  The type is either `Address` or `Postcode`
  """

  defstruct [:id, :type, :text, :highlight, :description]
  use ExConstructor
end
