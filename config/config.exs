use Mix.Config


################################# GENERAL #################################
# Connection ports
config :nautilus, :listen_port, 10000



################################# ACTIONS #################################
# Every module needs to implements action behaviour
config :nautilus, :MessageClientToClient, Nautilus
config :nautilus, :MessageClientToGateway, Nautilus
config :nautilus, :MessageGatewayToClient, Nautilus
config :nautilus, :MessageGatewayToGateway, Nautilus



################################# MODULES #################################

# Message - Port module
config :nautilus, :MessageActionPort, Nautilus.Ports.Message.MessageAction
config :nautilus, :MessageSenderPort, Nautilus.Ports.Message.MessageSender
config :nautilus, :MessagePreparatorPort, Nautilus.Ports.Message.MessagePreparator



# Network - Adapter module
config :nautilus, :TCPSender, Nautilus.Network.TCP.TCPSender
config :nautilus, :TCPHandler, Nautilus.Network.TCP.TCPHandler
config :nautilus, :TCPListener, Nautilus.Network.TCP.TCPListener
config :nautilus, :NetworkMessageHandler, Nautilus.Network.Message.NetworkMessageHandler



# Action - Core module
config :nautilus, :ActionMapper, Nautilus.Core.Action.ActionMapper



# Message - Core module
config :nautilus, :MessagePreparator, Nautilus.Core.Message.MessagePreparator



# Validators - Core module
config :nautilus, :MessageValidator, Nautilus.Core.Validators.MessageValidator.MessageValidator
config :nautilus, :MessageBodyValidator, Nautilus.Core.Validators.MessageValidator.Body.MessageBodyValidor
config :nautilus, :MessageHeaderValidator, Nautilus.Core.Validators.MessageValidator.Header.MessageHeaderValidator
config :nautilus, :MessageHeaderSyntaxValidator, Nautilus.Core.Validators.MessageValidator.Header.MessageHeaderSyntaxValidator



import_config "#{Mix.env()}.exs"
