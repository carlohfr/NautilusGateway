defmodule Nautilus.Core.Admin.ResponseRouter do

    @moduledoc """
    This module is responsible for routing response
    """

    @split Application.get_env(:nautilus, :Split)
    @cluster_manager Application.get_env(:nautilus, :ClusterManager)
    @cluster_discovery Application.get_env(:nautilus, :ClusterDiscovery)


    def route_response(pid, message, %{"message-notify" => "gateway-registered"}) do
        @cluster_discovery.send_discovery_message(pid, message["from"])
    end


    def route_response(_pid, message, %{"message-notify" => "gateway-list"}) do
        {_, content} =  @split.split_content(message["content"])
        @cluster_manager.prepare_gateway_list(content["gateway-list"])
    end


    def route_response(_pid, _message, _) do
        {:error, :indefined_response}
    end

end
