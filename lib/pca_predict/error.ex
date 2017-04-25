defmodule PCAPredict.Error do
  defstruct [:error, :description, :cause, :resolution]
  use ExConstructor
end
