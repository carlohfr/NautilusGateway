defmodule Nautilus.Core.Actions.RegisterClient do

    @moduledoc """
    This module is an action module for register a client
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @tcp_sender Application.get_env(:nautilus, :TCPSender)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @message_maker Application.get_env(:nautilus, :MessageMaker)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function will try to register the client. Then return id on success else return "ERROR"
    """
    def execute(pid, _message) do
        {_, id} = generate_client_id()

        client_info =  %{:pid => pid, :type => :client}

        with true <- Process.alive?(pid), :ok <- @key_value_adapter.set({id, client_info}) do
            {_, message} = @message_maker.make_send_to_client_message("gateway", id, id)
            @tcp_sender.send_message(pid, message)
        else
            false ->
                {:error, :invalidpid}
            _ ->
                {_, message} = @message_maker.make_send_to_client_message("gateway", id, "ERROR")
                @tcp_sender.send_message(pid, message)
        end
    end


    # This function will generate client id
    defp generate_client_id do
        uuid = UUID.uuid4()
        |> String.split("-")
        |> List.to_string()
        |> String.upcase()

        {_, hostname} = @get_hostname.get_hostname()
        id = "#{uuid}@#{hostname}"
        {:ok, id}
    end

end
