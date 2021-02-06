use Mix.Config


# Adpters modules
config :nautilus, :TCPListener, Nautilus.TCPMessageListener.TCPListener
config :nautilus, :TCPHandler, Nautilus.TCPMessageListener.TCPHandler
config :nautilus, :TCPSender, Nautilus.TCPMessageListener.TCPSender


# Core modules
config :nautilus, :MessageReceiver, Nautilus.Core.Message.MessageReceiver
config :nautilus, :MessageHandler, Nautilus.Core.Message.MessageHandler


# Connection ports
config :nautilus, :listen_port, 10000


import_config "#{Mix.env()}.exs"
