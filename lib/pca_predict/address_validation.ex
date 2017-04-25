defmodule PCAPredict.AddressValidation do

  def lookup(text, options \\ %{additional_lookup: false}) do
    PCAPredict.Client.request("/Capture/Interactive/Find/v1.00/json3ex.ws",
                          %{text: text})
    |> process_response(options)
  end

  def lookup_container(container) do
    PCAPredict.Client.request("/Capture/Interactive/Find/v1.00/json3ex.ws",
                          %{container: container})
  end

  defp process_response({:error, errors}, _options), do:
    {:error, errors}
  defp process_response({:ok, items}, %{additional_lookup: false}), do:
    {:ok, items}
  defp process_response({:ok, items}, %{additional_lookup: true}) do
    first_item = Enum.at(items, 0)
    lookup_container(first_item.id)
  end

end
