defmodule Nautilus.Core.Admin.AdminMessageRouter do

    @moduledoc """
    This module is resposible routing admin and control messages
    """

    @cluster_discovery Application.get_env(:nautilus, :ClusterDiscovery)


    def route_message(pid, message = %{"type" => "response"}) do
        {_, content} = split_content(message["content"])
        route_response(pid, message, content)
    end


    def route_message(_pid, _) do
        {:error, :indefined_type}
    end


    defp route_response(pid, _message, %{"message-notify" => "gateway-registered"}) do
        @cluster_discovery.send_discovery_message(pid)
    end


    defp route_response(_pid, _message, _) do
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
