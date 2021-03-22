use Mix.Config


################################# GENERAL #################################

config :nautilus, :env, :dev  #:prod, :dev, :test
config :nautilus, :listen_port, 10000
config :nautilus, :hostname_api_url, 'http://api.ipify.org'


################################# Adapters #################################

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
config :nautilus, :GetHostname, Nautilus.Adapters.Utils.GetHostname


################################# Ports #################################

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
config :nautilus, :RegisterClient, Nautilus.Core.Actions.RegisterClient
config :nautilus, :SendToClient, Nautilus.Core.Actions.SendToClient


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
