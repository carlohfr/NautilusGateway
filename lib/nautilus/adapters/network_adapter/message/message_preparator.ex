defmodule Nautilus.Adapters.Network.Message.MessagePreparator do

    @moduledoc """
    This module is responsible for transforming message received to a map() and send to core
    """

    @split Application.get_env(:nautilus, :Split)
    @message_handler Application.get_env(:nautilus, :MessageHandler)


    @doc """
    This function will control all steps of message preparation
    """
    def prepare_message(pid, message) do
        with {header_string, body} <- @split.split_message(message), {:ok, header} <- @split.split_content(header_string) do
            message = Map.put(header, "content", body)
            @message_handler.handle_message(pid, message)
        else
            _ ->
                {:error, :invalid}
        end
    end

end
