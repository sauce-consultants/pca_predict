# PCA Predict

A PCA Predict API wrapper for Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `pca_predict` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:pca_predict, "~> 0.1.0"}]
    end
    ```

  2. Ensure `pca_predict` is started before your application:

    ```elixir
    def application do
      [applications: [:pca_predict]]
    end
    ```

## Configuration

Obtain a PCA Predict API Key and assign it to a System ENV key of
`PCA_PREDICT_API_KEY`.

Alternatively, add the following to your `config.exs` file:

```
config :pca_predict,
  api_key: System.get_env("PCA_PREDICT_API_KEY")
```

## Usage

### Lookup postcode (address)

Retrieve a list of address options by calling
`PCAPredict.AddressValidation.lookup\1`
