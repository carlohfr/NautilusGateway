defmodule Nautilus.Core.Admin.ResponseRouter do

    @moduledoc """
    This module is responsible for routing response
    """

    @cluster_discovery Application.get_env(:nautilus, :ClusterDiscovery)


    def route_response(pid, message, %{"message-notify" => "gateway-registered"}) do
        @cluster_discovery.send_discovery_message(pid, message["from"])
    end


    def route_response(_pid, message, %{"message-notify" => "gateway-list"}) do
        IO.inspect(message)
    end


    def route_response(_pid, _message, _) do
        {:error, :indefined_response}
    end

end
