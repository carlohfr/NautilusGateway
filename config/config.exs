use Mix.Config


# Connection ports
config :nautilus, :listen_port, 10000








# Ports
config :nautilus, :MessageReceiverPort, Nautilus.Ports.MessageReceiver
config :nautilus, :MessageSenderPort, Nautilus.Ports.MessageSender


# Adapters modules
config :nautilus, :TCPListener, Nautilus.Network.TCPListener
config :nautilus, :TCPHandler, Nautilus.Network.TCPHandler
config :nautilus, :TCPSender, Nautilus.Network.TCPSender


# Message - Core module
config :nautilus, :MessageReceiver, Nautilus.Core.Message.MessageReceiver
config :nautilus, :MessageHandler, Nautilus.Core.Message.MessageHandler


# Protocol - Core module
config :nautilus, :MessageHeaderProtocol, Nautilus.Core.Protocol.MessageHeaderProtocol


# Validators - Core module
config :nautilus, :MessageValidator, Nautilus.Core.Validators.MessageValidator
config :nautilus, :MessageHeaderValidator, Nautilus.Core.Validators.MessageValidator.MessageHeaderValidator
config :nautilus, :MessageBodyValidator, Nautilus.Core.Validators.MessageValidator.MessageBodyValidor
config :nautilus, :MessageHeaderSyntaxValidator, Nautilus.Core.Validators.MessageValidator.MessageHeaderSyntaxValidator


# Aceppted header fields - Dont change this
config :nautilus, :MessageHeaderV1, ["version", "to", "from", "action", "type", "size"]


import_config "#{Mix.env()}.exs"
