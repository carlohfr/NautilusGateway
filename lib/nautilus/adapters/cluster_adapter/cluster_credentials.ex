defmodule Nautilus.Adapters.Cluster.ClusterCredentials do

    @moduledoc """
    This module is responsible for handle network credentials
    """

    @doc """
    This function will store all network credentials
    """
    def set_network_credentials(_network_name, _network_password, _gateway_password) do
        {:ok, :set}
    end


    @doc """
    This function will return all network credentials
    """
    def get_network_credentials do

        #get from key value
        network_name = "rede1"
        network_password = "1q2w3e4r"
        gateway_password = "pass"

        {:ok, network_name, network_password, gateway_password}
    end


    @doc """
    This function will check if network credentials is valid
    """
    def check_network_credentials(_network_name, _network_password, _gateway_password) do
        {:ok, :valid}
    end

end
