defmodule Nautilus.Core.Actions.RegisterClient do

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @tcp_sender Application.get_env(:nautilus, :TCPSender)
    @message_maker Application.get_env(:nautilus, :MessageMaker)
    @client_registry Application.get_env(:nautilus, :ClientRegistry)


    # This function will try to register the client. Then return id on success else return "ERROR"
    def execute(pid, message) do
        {_, id} = @client_registry.generate_client_id

        client_info =  %{:pid => pid, :type => :client}

        case @client_registry.register_client(id, client_info) do
            {:ok, _} ->
                {_, message} = @message_maker.make_notify_message(message["version"], "gateway", id, id)
                @tcp_sender.send_message(pid, message)
            _ ->
                {_, message} = @message_maker.make_notify_message(message["version"], "gateway", id, "ERROR")
                @tcp_sender.send_message(pid, message)
        end
    end

end
