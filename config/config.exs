use Mix.Config


################################## Network ##################################

config :nautilus, :new_network, true
config :nautilus, :network_name, "rede1"
config :nautilus, :gateway_password, "pass"
config :nautilus, :network_password, "1q2w3e4r"
config :nautilus, :remote_gateways, [{{127,0,0,1}, 10000}]


################################## General ##################################

config :nautilus, :env, :dev  #:prod, :dev, :test
config :nautilus, :listen_port, 10000
config :nautilus, :hostname_api_url, 'http://api.ipify.org'


################################# Adapters #################################

# Cluster - Adapter module
config :nautilus, :ClusterClient, Nautilus.Adapters.Cluster.ClusterClient
config :nautilus, :ClusterManager, Nautilus.Adapters.Cluster.ClusterManager
config :nautilus, :ClusterDiscovery, Nautilus.Adapters.Cluster.ClusterDiscovery
config :nautilus, :ClusterCredentials, Nautilus.Adapters.Cluster.ClusterCredentials


# Key_value - Adapter module
config :nautilus, :KeyValueBucket, Nautilus.Adapters.KeyValue.Bucket
config :nautilus, :KeyValueBucketInterface, Nautilus.Adapters.KeyValue.BucketInterface


# Network - Adapter module
config :nautilus, :TCPSender, Nautilus.Adapters.Network.TCP.TCPSender
config :nautilus, :TCPHandler, Nautilus.Adapters.Network.TCP.TCPHandler
config :nautilus, :TCPListener, Nautilus.Adapters.Network.TCP.TCPListener
config :nautilus, :MessageMaker, Nautilus.Adapters.Network.Message.MessageMaker
config :nautilus, :MessagePreparator, Nautilus.Adapters.Network.Message.MessagePreparator


# Utils - Adapter module
config :nautilus, :Split, Nautilus.Adapters.Utils.Split
config :nautilus, :GetHostname, Nautilus.Adapters.Utils.GetHostname


################################# Ports #################################


# Cluster - Port module
config :nautilus, :ClusterDiscoveryPort, Nautilus.Ports.Cluster.ClusterDiscoveryPort


# Message - Port module
config :nautilus, :MessageActionPort, Nautilus.Ports.Message.MessageAction
config :nautilus, :MessageSenderPort, Nautilus.Ports.Message.MessageSender
config :nautilus, :MessageHandlerPort, Nautilus.Ports.Message.MessageHandler
config :nautilus, :MessageMakerPort, Nautilus.Ports.Message.MessageMaker


# Key_value - Port module
config :nautilus, :KeyValueBucketInterfacePort, Nautilus.Ports.KeyValue.KeyValueBucketInterface


# Utils - Port module
config :nautilus, :GetHostnamePort, Nautilus.Ports.Utils.GetHostname


################################# Core #################################

# Actions - Core module - Every module needs to implements action behaviour
config :nautilus, :SendToClient, Nautilus.Core.Actions.SendToClient
config :nautilus, :SendToGateway, Nautilus.Core.Actions.SendToGateway
config :nautilus, :RegisterClient, Nautilus.Core.Actions.RegisterClient
config :nautilus, :RegisterGateway, Nautilus.Core.Actions.RegisterGateway
config :nautilus, :ForwardToClient, Nautilus.Core.Actions.ForwardToClient
config :nautilus, :ForwardToGateway, Nautilus.Core.Actions.ForwardToGateway
config :nautilus, :TestAction, Nautilus.Core.Actions.TestAction


# Admin - Core module
config :nautilus, :AdminMessageRouter, Nautilus.Core.Admin.AdminMessageRouter
config :nautilus, :CommandRouter, Nautilus.Core.Admin.CommandRouter
config :nautilus, :ResponseRouter, Nautilus.Core.Admin.ResponseRouter


# Admin/Commands - Core module
config :nautilus, :CMDKick, Nautilus.Core.Admin.Commands.CMDKick
config :nautilus, :CMDGetGatewayList, Nautilus.Core.Admin.Commands.CMDGetGatewayList


# Endpoint - Core module
config :nautilus, :ActionMapper, Nautilus.Core.Endpoint.ActionMapper
config :nautilus, :MessageHandler, Nautilus.Core.Endpoint.MessageHandler


# Validators - Core module
config :nautilus, :ClientValidator, Nautilus.Core.Validators.ClientValidator.ClientValidator
config :nautilus, :MessageValidator, Nautilus.Core.Validators.MessageValidator.MessageValidator
config :nautilus, :MessageSyntaxValidator, Nautilus.Core.Validators.MessageValidator.MessageSyntaxValidator
config :nautilus, :MessageContentSizeValidator, Nautilus.Core.Validators.MessageValidator.MessageContentSizeValidator


########################################################################

import_config "#{Mix.env()}.exs"
