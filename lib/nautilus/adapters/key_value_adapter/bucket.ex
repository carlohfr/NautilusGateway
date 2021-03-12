defmodule Nautilus.Adapters.KeyValue.Bucket do

    use GenServer


    def start_link(_) do
        GenServer.start_link(__MODULE__, Map.new, name: :bucket)
    end


    def init(default) do
        {:ok, default}
    end


    def handle_call({:set, {key, value}}, _from, state) do
        {:reply, :ok, Map.put(state, key, value)}
    end


    def handle_call({:get, key}, _from, state) do
        {:reply, Map.fetch(state, key), state}
    end


    def handle_call(:get_all, _from, state) do
        {:reply, state, state}
    end


    def handle_call({:delete, key}, _from, state) do
        {:reply, :ok, Map.delete(state, key)}
    end

end
