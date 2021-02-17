defmodule Nautilus.KeyValue.BucketInterface do

    @behaviour Application.get_env(:nautilus, :KeyValueBucketInterfacePort)


    def set({key, value}) do
        GenServer.call(:bucket, {:set, {key, value}})
    end


    def get(key) do
        GenServer.call(:bucket, {:get, key})
    end


    def get_all do
        GenServer.call(:bucket, :get_all)
    end


    def delete(key) do
        GenServer.call(:bucket, {:delete, key})
    end

end
