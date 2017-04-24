defmodule PCAPredict.Client do
  @moduledoc """
  An HTTP client for PCAPredict.
  """

  # Build the client on top of HTTPoison
  use Application
  use HTTPoison.Base

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

  defp parse_response(%{"Items" => [%{"Error" => _error}]} = json) do
    error_cause =
      json["Items"]
      |> Enum.at(0)
    {:error, error_cause["Description"], error_cause["Resolution"]}
  end
  defp parse_response(%{"Items" => results}), do:
    {:ok, results}

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
      {:error, error} -> {:error, error.reason, nil}
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

