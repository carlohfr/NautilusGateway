use Mix.Config

config :nautilus, :listen_port, 10000

import_config "#{Mix.env()}.exs"
