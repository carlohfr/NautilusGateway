use Mix.Config


# Connection ports
config :nautilus, :listen_port, 10000



# Message - Port module
config :nautilus, :MessageReceiverPort, Nautilus.Ports.Message.MessageReceiver
config :nautilus, :MessageSenderPort, Nautilus.Ports.Message.MessageSender


# Network - Adapter module
config :nautilus, :MessagePreparator, Nautilus.Network.Message.MessagePreparator
config :nautilus, :MessageSplit, Nautilus.Network.Message.MessageSplit
config :nautilus, :TCPListener, Nautilus.Network.TCP.TCPListener
config :nautilus, :TCPHandler, Nautilus.Network.TCP.TCPHandler
config :nautilus, :TCPSender, Nautilus.Network.TCP.TCPSender


# Message - Core module
config :nautilus, :MessageReceiver, Nautilus.Core.Message.MessageReceiver
config :nautilus, :MessageHandler, Nautilus.Core.Message.MessageHandler


# Validators - Core module
config :nautilus, :MessageValidator, Nautilus.Core.Validators.MessageValidator.MessageValidator
config :nautilus, :MessageBodyValidator, Nautilus.Core.Validators.MessageValidator.Body.MessageBodyValidor
config :nautilus, :MessageHeaderValidator, Nautilus.Core.Validators.MessageValidator.Header.MessageHeaderValidator
config :nautilus, :MessageHeaderSyntaxValidator, Nautilus.Core.Validators.MessageValidator.Header.MessageHeaderSyntaxValidator




import_config "#{Mix.env()}.exs"
