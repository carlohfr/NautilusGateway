defmodule Nautilus.Ports.Cluster.ClusterDiscoveryPort do

    @moduledoc """
    This module establish a behavior for Cluster discovery
    """

    @doc """
    This function will send a discovery message to remote gateway
    """
    @callback send_discovery_message(pid :: pid()) :: any

end
