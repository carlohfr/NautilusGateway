defmodule Nautilus.Core.Endpoint.ActionMapper do

    def get_action("say-hi"), do: {:ok, :SayHi}
    def get_action("register-client"), do: {:ok, :RegisterClient}
    def get_action(_), do: {:error, :no_action_found}

end
