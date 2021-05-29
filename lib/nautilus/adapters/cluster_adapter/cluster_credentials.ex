defmodule Nautilus.Adapters.Cluster.ClusterCredentials do

    @moduledoc """
    This module is responsible for handle network credentials
    """

    #@doc """
    #This function will store all network credentials
    #"""
    #def set_network_credentials(_network_name, _network_password, _gateway_password) do
    #    {:ok, :set}
    #end


    @doc """
    This function will return all network credentials
    """
    def get_network_credentials do
        network_name = Application.get_env(:nautilus, :network_name)
        network_password = Application.get_env(:nautilus, :network_password)
        gateway_password = Application.get_env(:nautilus, :gateway_password)

        {:ok, network_name, network_password, gateway_password}
    end


    @doc """
    This function will check if network credentials is valid
    """
    def check_network_credentials(_network_name, _network_password, _gateway_password) do
        {:ok, :valid}
    end

end
