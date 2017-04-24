defmodule PCAPredict.AddressValidation do

  def lookup(text) do
    PCAPredict.Client.request("/Capture/Interactive/Find/v1.00/json3ex.ws",
                          %{text: text})
  end

end
