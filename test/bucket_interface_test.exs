defmodule BucketInterfaceTest do

    use ExUnit.Case

    @bucket_interface Application.get_env(:nautilus, :KeyValueBucketInterface)

    test "bucket interface test" do
        key = "test"
        value = "test message"

        # Set a value
        assert @bucket_interface.set({key, value}) == :ok

        # Get a value
        assert @bucket_interface.get(key) == {:ok, "test message"}

        # Delete value
        assert @bucket_interface.delete(key) == :ok
    end

end
