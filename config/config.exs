use Mix.Config


################################# GENERAL #################################
# Connection ports
config :nautilus, :listen_port, 10000


################################# Ports #################################

# Message - Port module
config :nautilus, :MessageActionPort, Nautilus.Ports.Message.MessageAction
config :nautilus, :MessageSenderPort, Nautilus.Ports.Message.MessageSender
config :nautilus, :MessageHandlerPort, Nautilus.Ports.Message.MessageHandler
config :nautilus, :KeyValueBucketInterfacePort, Nautilus.Ports.KeyValue.KeyValueBucketInterface


################################# Adapters #################################

# Key_value - Adapter module
config :nautilus, :KeyValueBucket, Nautilus.KeyValue.Bucket
config :nautilus, :KeyValueBucketInterface, Nautilus.KeyValue.BucketInterface


# Network - Adapter module
config :nautilus, :TCPSender, Nautilus.Network.TCPSender
config :nautilus, :TCPHandler, Nautilus.Network.TCPHandler
config :nautilus, :TCPListener, Nautilus.Network.TCPListener
config :nautilus, :MessagePreparator, Nautilus.Network.MessagePreparator


################################# Core #################################

# Actions - Core module - Every module needs to implements action behaviour
config :nautilus, :SayHi, Nautilus.Core.Actions.SayHi


# EntryPoint - Core module
config :nautilus, :ActionMapper, Nautilus.Core.EntryPoint.ActionMapper
config :nautilus, :MessageHandler, Nautilus.Core.EntryPoint.MessageHandler


# Validators - Core module
config :nautilus, :MessageValidator, Nautilus.Core.Validators.MessageValidator.MessageValidator
config :nautilus, :MessageBodyValidator, Nautilus.Core.Validators.MessageValidator.Body.MessageBodyValidor
config :nautilus, :MessageHeaderValidator, Nautilus.Core.Validators.MessageValidator.Header.MessageHeaderValidator
config :nautilus, :MessageHeaderSyntaxValidator, Nautilus.Core.Validators.MessageValidator.Header.MessageHeaderSyntaxValidator


########################################################################

import_config "#{Mix.env()}.exs"
