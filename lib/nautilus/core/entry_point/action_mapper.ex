defmodule Nautilus.Core.EntryPoint.ActionMapper do

    def get_action(action) do
        actions = %{
            "say-hi" => :SayHi
        }

        if Map.has_key?(actions, action) do
            {:ok, actions[action]}
        else
            :invalid
        end
    end

end
