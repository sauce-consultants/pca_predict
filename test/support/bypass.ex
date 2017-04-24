defmodule PCAPredict.Support.Bypass do

  def setup_and_open do
    bypass = Bypass.open

    endpoint = "http://localhost:#{bypass.port}"
    Application.put_env :pca_predict, :endpoint, endpoint

    bypass
  end

end
