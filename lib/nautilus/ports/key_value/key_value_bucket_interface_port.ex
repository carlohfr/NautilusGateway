defmodule Nautilus.Ports.KeyValue.KeyValueBucketInterface do
    @callback set({key :: any , value :: any}) :: any
    @callback delete(key :: any) :: any
    @callback get(key :: any) :: any
    @callback get_all :: any
end
