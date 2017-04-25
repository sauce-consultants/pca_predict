defmodule PCAPredict.Client do
  @moduledoc """
  An HTTP client for PCAPredict.
  """

  # Build the client on top of HTTPoison
  use Application
  use HTTPoison.Base

  alias PCAPredict.{Error, Item}

  def start(_type, _args) do
    PCAPredict.Supervisor.start_link
  end

  @doc """
  Creates the URL for our endpoint.
  """
  def process_url(endpoint) do
    Application.get_env(:pca_predict, :endpoint) <> endpoint
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> parse_response
  end

  defp parse_response(%{"Items" => [%{"Error" => _error}] = errors}) do
    data =
      errors
      |> Enum.map(fn(item) ->
        Error.new(item)
      end)

    {:error, data}
  end
  defp parse_response(%{"Items" => items}) do
    data =
      items
      |> Enum.map(fn(item) ->
        Item.new(item)
      end)

    {:ok, data}
  end

  @doc """
  Boilerplate code to make requests.
  """
  def request(endpoint, body \\ %{})

  def request(endpoint, %{key: _} = params) do
    PCAPredict.Client.get(
      endpoint,
      [],
      params: params,
      ssl: [versions: [:"tlsv1.2"]]
    )
    |> case do
      {:ok, response} -> response.body
      {:error, error} -> {:error, error.reason}
    end
  end

  def request(endpoint, params) do
    request(endpoint, Map.put(params, :key, api_key()))
  end

  @doc """
  Gets the api key from :pca_predict, :api_key application env or
  PCA_PREDICT_API_KEY from system ENV
  """
  def api_key do
   Application.get_env(:pca_predict, :api_key) ||
     System.get_env("PCA_PREDICT_API_KEY")
  end

end

