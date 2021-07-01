defmodule Nautilus.Core.Admin.ResponseRouter do

    @moduledoc """
    This module is responsible for routing response
    """

    @cluster_discovery Application.get_env(:nautilus, :ClusterDiscovery)
    @cluster_manager Application.get_env(:nautilus, :ClusterManager)


    def route_response(pid, message, %{"message-notify" => "gateway-registered"}) do
        @cluster_discovery.send_discovery_message(pid, message["from"])
    end


    def route_response(_pid, message, %{"message-notify" => "gateway-list"}) do
        {_, content} = split_content(message["content"])
        @cluster_manager.prepare_gateway_list(content["gateway-list"])
    end


    def route_response(_pid, _message, _) do
        {:error, :indefined_response}
    end


    defp split_content(content) do
        case String.contains?(content, ["\r\n", ": "]) do
            true ->
                filtered_content = content
                |> String.split(["\r\n", ": "])
                |> Enum.chunk_every(2)
                |> Enum.map(fn [a, b] -> {a, b} end)
                |> Map.new

                {:ok, filtered_content}
            _ ->
                {:error, :no_fields}
        end
    end

end
