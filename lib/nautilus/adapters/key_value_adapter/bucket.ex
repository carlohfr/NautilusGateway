defmodule Nautilus.Adapters.KeyValue.Bucket do

    @moduledoc """
    This module is responsible for storing values
    """

    use GenServer


    @doc """
    This function is the main function of this module, and will be executed first
    """
    def start_link(_) do
        GenServer.start_link(__MODULE__, Map.new, name: :bucket)
    end


    @doc """
    This function is a callback function for start_link()
    """
    def init(default) do
        {:ok, default}
    end


    @doc """
    This function is a callback function for storing a value on this bucket
    """
    def handle_call({:set, {key, value}}, _from, state) do
        {:reply, :ok, Map.put(state, key, value)}
    end


    @doc """
    This function is a callback function for get a value stored on this bucket
    """
    def handle_call({:get, key}, _from, state) do
        {:reply, Map.fetch(state, key), state}
    end


    @doc """
    This function is a callback function for get all values stored on this bucket
    """
    def handle_call(:get_all, _from, state) do
        {:reply, state, state}
    end


    @doc """
    This function is a callback function for delete a value stored on this bucket
    """
    def handle_call({:delete, key}, _from, state) do
        {:reply, :ok, Map.delete(state, key)}
    end

end
