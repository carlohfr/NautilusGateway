defmodule Nautilus.Ports.KeyValue.KeyValueBucketInterface do

    @moduledoc """
    This module establish a behavior for key value interface
    """

    @doc """
    This function will receive a key and a value and set to the bucket
    """
    @callback set({key :: any , value :: any}) :: any

    @doc """
    This function will receive a key and delete a value saved on bucket
    """
    @callback delete(key :: any) :: any

    @doc """
    This function will receive a key and return a value saved on bucket
    """
    @callback get(key :: any) :: any

    @doc """
    This function will return all values saved on bucket
    """
    @callback get_all :: any

end
