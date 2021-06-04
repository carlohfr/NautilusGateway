defmodule Nautilus.Ports.Message.MessageMaker do

    @moduledoc """
    This module establish a behavior for message maker
    """

    @doc """
    This function will make a message
    """
    @callback make_message(message :: map()) :: any


    @doc """
    This function will make a notify message
    """
    @callback make_send_to_client_message(from :: String.t , to :: String.t, content :: String.t) :: any


    @doc """
    This function will make a notify message
    """
    @callback make_send_to_gateway_message(type :: String.t, from :: String.t, to :: String.t, content :: String.t) :: any

end
