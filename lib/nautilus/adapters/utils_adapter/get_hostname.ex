defmodule Nautilus.Adapters.Utils.GetHostname do

    @moduledoc """
    This module is responsible for return the current hostname
    """

    @behaviour Application.get_env(:nautilus, :GetHostnamePort)
    @port Application.get_env(:nautilus, :listen_port)
    @hostname_api_url Application.get_env(:nautilus, :hostname_api_url)


    # This function will return the env variable (:prod, :dev, :test)
    defp return_env, do: Application.get_env(:nautilus, :env)


    @doc """
    This function will return the hostname
    """
    def get_hostname() do
        case return_env() do
            :dev ->
                {:ok, "127.0.0.1:#{@port}"}
            _ ->
                {:ok, {_, _, ip}} = :httpc.request(@hostname_api_url)
                address ="#{ip}:#{@port}"
                {:ok, address}
        end
    end

end
