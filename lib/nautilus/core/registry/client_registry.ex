defmodule Nautilus.Core.Registry.ClientRegistry do

    @moduledoc """
    This module is responsible for register a new client into the gateway
    """

    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)
    @get_hostname Application.get_env(:nautilus, :GetHostname)


    @doc """
    This function is responsible for call key value adapter and save client info
    """
    def register_client(client_id, client_info) do
        case @key_value_adapter.set({client_id, client_info}) do
            :ok ->
                {:ok, :registered}
            _ ->
                {:error, :non_registered}
        end
    end


    @doc """
    This function is responsible for call key value adapter and delete client info
    """
    def unregister_client(client_id) do
        @key_value_adapter.delete(client_id)
    end


    @doc """
    This function is responsible for call key value adapter and get client info
    """
    def get_client_info(client_id) do
       @key_value_adapter.get(client_id)
    end


    @doc """
    This function is responsible for call key value adapter and get all clients info
    """
    def get_all_clients do
        @key_value_adapter.get_all()
    end


    @doc """
    This function is responsible for generate a client id
    """
    def generate_client_id do
        uuid = UUID.uuid4()
        |> String.split("-")
        |> List.to_string()
        |> String.upcase()

        {_, hostname} = @get_hostname.get_hostname()
        id = "#{uuid}@#{hostname}"
        IO.inspect(id)
        {:ok, id}
    end

end
