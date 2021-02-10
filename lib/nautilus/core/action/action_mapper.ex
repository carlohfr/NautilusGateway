defmodule Nautilus.Core.Action.ActionMapper do

    def get_action(action) do
        actions = %{
            "client-to-client" => :MessageClientToClient,
            "client-to-gateway" => :MessageClientToGateway,
            "gateway-to-client" => :MessageGatewayToClient,
            "gateway-to-gateway" => :MessageGatewayToGateway
        }

        if Map.has_key?(actions, action) do
            {:ok, actions[action]}
        else
            :invalid
        end
    end

end
