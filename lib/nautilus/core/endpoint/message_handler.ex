defmodule Nautilus.Core.Endpoint.MessageHandler do

    @behaviour Application.get_env(:nautilus, :MessageHandlerPort)
    @action_mapper Application.get_env(:nautilus, :ActionMapper)
    @message_validator Application.get_env(:nautilus, :MessageValidator)


    def handle_message(pid, message) do
        case @message_validator.validate_message(message) do
            {:valid, _} ->
                case @action_mapper.get_action(message["action"]) do
                    {:ok, module} ->
                        action = Application.get_env(:nautilus, module)
                        action.execute(pid, message)
                    _ ->
                        {:error, :no_action}
                end
            _ ->
                {:error, :invalid_message}
        end
    end

end
