defmodule Nautilus.Core.Admin.AdminMessageRouter do

    @moduledoc """
    This module is resposible routing admin and control messages
    """

    @command_router Application.get_env(:nautilus, :CommandRouter)
    @response_router Application.get_env(:nautilus, :ResponseRouter)


    def route_message(pid, message = %{"type" => "response"}) do
        {_, content} = split_content(message["content"])
        @response_router.route_response(pid, message, content)
    end


    def route_message(pid, message = %{"type" => "command"}) do
        {_, content} = split_content(message["content"])
        @command_router.route_command(pid, message, content)
    end


    def route_message(_pid, _) do
        {:error, :indefined_type}
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
