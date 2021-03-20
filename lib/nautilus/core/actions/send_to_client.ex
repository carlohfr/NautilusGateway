defmodule Nautilus.Core.Actions.SendToClient do

    @moduledoc """
    This module is an action module for send message to a client
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    #@tcp_sender Application.get_env(:nautilus, :TCPSender)
    #@message_maker Application.get_env(:nautilus, :MessageMaker)


    @doc """
    This function will try to send message to a client.
    """
    def execute(_pid, _message) do

        # validar o client remetente (se esta conectado ou nao)
        # buscar o client destinatario no registro
        # montar a mensagem
        # enviar a mensagem


        :ok
    end

end
