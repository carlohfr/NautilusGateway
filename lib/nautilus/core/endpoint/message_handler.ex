defmodule Nautilus.Core.Endpoint.MessageHandler do

    @behaviour Application.get_env(:nautilus, :MessageHandlerPort)
    @message_validator Application.get_env(:nautilus, :MessageValidator)
    @action_mapper Application.get_env(:nautilus, :ActionMapper)


    def handle_message(pid, header, body) do
        case @message_validator.validate_message(header, body) do
            {:valid, header, body} ->
                case @action_mapper.get_action(header["action"]) do
                    {:ok, module} ->
                        action = Application.get_env(:nautilus, module)
                        action.execute(pid, header, body)
                    _ ->
                        {:error, :noaction}
                end
            _ ->
                {:error, :invalidmessage}
        end
    end

end
