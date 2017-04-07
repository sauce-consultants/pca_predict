defmodule PCAPredict.Client do
  @moduledoc """
  An HTTP client for PCAPredict.
  """

  # Build the client on top of HTTPoison
  use Application
  use HTTPoison.Base

  import SweetXml

  def start(_type, _args) do
    PCAPredict.Supervisor.start_link
  end

  @doc """
  Creates the URL for our endpoint.
  """
  def process_url(endpoint) do
    "https://services.postcodeanywhere.co.uk" <> endpoint
  end

  def process_response_body(body) do
    if has_error_in_request?(body) do
      process_error_response(body)
    else
      process_success_response(body)
    end
  end

  defp process_success_response(body) do
    body
    |> xmap(
      results: [
        ~x"//Table/Row"l,
        id: ~x"./Id/text()"s,
        type: ~x"./Type/text()"s,
        text: ~x"./Text/text()"s,
        highlight: ~x"./Highlight/text()"s,
        description: ~x"./Description/text()"s
      ]
    )
  end

  defp process_error_response(body) do
    body
    |> xmap(
      error: [
        ~x"//Table/Row"e,
        error: ~x"./Error/text()"s,
        description: ~x"./Description/text()"s,
        cause: ~x"./Cause/text()"s,
        resolution: ~x"./Resolution/text()"s,
      ]
    )
  end

  defp has_error_in_request?(body) do
    errors =
      body
      |> xpath(~x"//Table/Row/Error"l)

    length(errors) > 0
  end

  @doc """
  Boilerplate code to make requests.
  """
  def request(endpoint, body \\ %{})

  def request(endpoint, %{key: _} = params) do
    PCAPredict.Client.get!(
      endpoint,
      [],
      params: params,
      ssl: [versions: [:"tlsv1.2"]]
    ).body
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

