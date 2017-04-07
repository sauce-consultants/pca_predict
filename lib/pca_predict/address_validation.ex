defmodule PCAPredict.AddressValidation do

  def lookup(text) do
    PCAPredict.Client.request("/Capture/Interactive/Find/v1.00/xmle.ws",
                          %{text: text})
  end
end
