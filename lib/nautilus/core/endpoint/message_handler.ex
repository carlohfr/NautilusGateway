defmodule Nautilus.Core.Endpoint.MessageHandler do

    @moduledoc """
    This module is responsible for receiving a message, validate, get an action and execute
    """

    @behaviour Application.get_env(:nautilus, :MessageHandlerPort)
    @action_mapper Application.get_env(:nautilus, :ActionMapper)
    @message_validator Application.get_env(:nautilus, :MessageValidator)


    @doc """
    This function will handle a message
    """
    def handle_message(pid, message) do
        with {:valid, _} <- @message_validator.validate_message(message),
        {:ok, module} <- @action_mapper.get_action(message["action"]) do
            action = Application.get_env(:nautilus, module)
            action.execute(pid, message)
        else
            _ ->
                {:error, :invalid}
        end
    end

end
