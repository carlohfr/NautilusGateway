defmodule Nautilus.Core.Admin.Commands.CMDKick do

    @moduledoc """
    This module is responsible for process get gateway list command
    """

    @split Application.get_env(:nautilus, :Split)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    def execute_command(_pid, message) do
        {_, content} = @split.split_content(message["content"])
        target = content["target"]

        with {:ok, target_info} <- @key_value_adapter.get(target) do
            GenServer.cast(target_info[:pid], {:kick})
        else
            _ ->
                # Para o futuro colocar aqui o codigo para o kick em outro gateway
                {:error, :notarget}
        end
    end

end
