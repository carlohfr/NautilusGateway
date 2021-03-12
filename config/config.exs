use Mix.Config


################################# GENERAL #################################

config :nautilus, :env, :prod  #:prod, :dev, :test
config :nautilus, :listen_port, 10000
config :nautilus, :hostname_api_url, 'http://api.ipify.org'


################################# Adapters #################################

# Key_value - Adapter module
config :nautilus, :KeyValueBucket, Nautilus.KeyValue.Bucket
config :nautilus, :KeyValueBucketInterface, Nautilus.KeyValue.BucketInterface


# Network - Adapter module
config :nautilus, :TCPSender, Nautilus.Network.TCP.TCPSender
config :nautilus, :TCPHandler, Nautilus.Network.TCP.TCPHandler
config :nautilus, :TCPListener, Nautilus.Network.TCP.TCPListener
config :nautilus, :MessageMaker, Nautilus.Network.Message.MessageMaker
config :nautilus, :MessagePreparator, Nautilus.Network.Message.MessagePreparator


# Utils - Adapter module
config :nautilus, :GetHostname, Nautilus.Utils.GetHostname


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
config :nautilus, :SayHi, Nautilus.Core.Actions.SayHi
config :nautilus, :RegisterClient, Nautilus.Core.Actions.RegisterClient


# Endpoint - Core module
config :nautilus, :ActionMapper, Nautilus.Core.Endpoint.ActionMapper
config :nautilus, :MessageHandler, Nautilus.Core.Endpoint.MessageHandler


# Registry - Core module
config :nautilus, :ClientRegistry, Nautilus.Core.Registry.ClientRegistry


# Validators - Core module
config :nautilus, :MessageValidator, Nautilus.Core.Validators.MessageValidator.MessageValidator
config :nautilus, :MessageSyntaxValidator, Nautilus.Core.Validators.MessageValidator.MessageSyntaxValidator
config :nautilus, :MessageContentSizeValidator, Nautilus.Core.Validators.MessageValidator.MessageContentSizeValidator


########################################################################

import_config "#{Mix.env()}.exs"
