defmodule PCAPredict.Item do
  defstruct [:id, :type, :text, :highlight, :description]
  use ExConstructor
end
