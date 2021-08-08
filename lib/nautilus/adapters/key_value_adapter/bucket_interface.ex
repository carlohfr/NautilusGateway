defmodule Nautilus.Adapters.KeyValue.BucketInterface do

    @moduledoc """
    This module is responsible for controlling the key value bucket
    """

    @behaviour Application.get_env(:nautilus, :KeyValueBucketInterfacePort)


    @doc """
    This function will receive a key and a value and set to the bucket
    """
    def set({key, value}) do
        case get(key) do
            :error ->
                GenServer.call(:bucket, {:set, {key, value}})
            _ ->
                {:error, :key_already_exists}
        end
    end


    @doc """
    This function will receive a key and return a value saved on bucket
    """
    def get(key) do
        GenServer.call(:bucket, {:get, key})
    end


    @doc """
    This function will return all values saved on bucket
    """
    def get_all do
        GenServer.call(:bucket, :get_all)
    end


    @doc """
    This function will return a list of clients
    """
    def get_client_list do
        client_list = Enum.reject(get_all(), fn client -> elem(client, 1).type == :gateway end)
        |> Enum.map(fn {key, _value} -> key end)

        {:ok, client_list}
    end


    @doc """
    This function will return a list of gateways
    """
    def get_gateway_list do
        gateway_list = Enum.reject(get_all(), fn gateway -> elem(gateway, 1).type == :client end)
        |> Enum.map(fn {key, _value} -> key end)

        {:ok, gateway_list}
    end


    @doc """
    This function will receive a key and delete a value saved on bucket
    """
    def delete(key) do
        GenServer.call(:bucket, {:delete, key})
    end

end
