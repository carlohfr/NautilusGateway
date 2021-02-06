use Mix.Config


# Ports
config :nautilus, :MessageReceiverPort, Nautilus.Ports.MessageReceiver
config :nautilus, :MessageSenderPort, Nautilus.Ports.MessageSender


# Adapters modules
config :nautilus, :TCPListener, Nautilus.Network.TCPListener
config :nautilus, :TCPHandler, Nautilus.Network.TCPHandler
config :nautilus, :TCPSender, Nautilus.Network.TCPSender


# Core modules
config :nautilus, :MessageReceiver, Nautilus.Core.Message.MessageReceiver
config :nautilus, :MessageHandler, Nautilus.Core.Message.MessageHandler


# Connection ports
config :nautilus, :listen_port, 10000


import_config "#{Mix.env()}.exs"
