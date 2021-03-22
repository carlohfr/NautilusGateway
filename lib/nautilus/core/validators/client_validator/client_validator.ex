defmodule Nautilus.Core.Validators.ClientValidator.ClientValidator do

    @moduledoc """
    This module is responsible for validate client
    """

    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function receive a id and pid
    """
    def validate_client(id, pid) do
        with {:ok, client_info} <- @key_value_adapter.get(id), true <- Process.alive?(client_info[:pid]),
        true <- client_info[:pid] == pid do
            {:ok, :validclient}
        else
            _ ->
                _status = @key_value_adapter.delete(id)
                {:error, :invalidclient}
        end
    end

end
