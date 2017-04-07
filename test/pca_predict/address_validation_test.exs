defmodule PCAPredict.AddressValidationTest do
  use ExUnit.Case

  test "request to a valid endpoint returns a valid response" do
    %{results: results} = PCAPredict.AddressValidation.lookup("HU1 1UU")
    assert results |> Enum.count == 1
  end

  test "request to a valid endpoint returns a valid multiple response" do
    %{results: results} = PCAPredict.AddressValidation.lookup("WR2 6NJ")
    assert results |> Enum.count == 2
  end

  test "request to an invalid endpoint returns a valid response" do
    %{error: error} = PCAPredict.AddressValidation.lookup("")
    assert error == %{cause: "The Text or Container parameters were not supplied.", description: "Text or Container Required", error: "1001", resolution: "Check they were supplied and try again."}
  end
end
