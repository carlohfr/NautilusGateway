defmodule Nautilus.Core.Endpoint.ActionMapper do

    def get_action("say-hi"), do: {:ok, :SayHi}
    def get_action(_), do: {:error, :nofound}

end
