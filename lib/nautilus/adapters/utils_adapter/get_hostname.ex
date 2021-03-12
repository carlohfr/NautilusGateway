defmodule Nautilus.Utils.GetHostname do

    @behaviour Application.get_env(:nautilus, :GetHostnamePort)
    @port Application.get_env(:nautilus, :listen_port)
    @hostname_api_url Application.get_env(:nautilus, :hostname_api_url)

    defp return_env, do: Application.get_env(:nautilus, :env)

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
