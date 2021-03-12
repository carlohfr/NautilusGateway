defmodule Nautilus.Network.Message.MessageMaker do

    @behaviour Application.get_env(:nautilus, :MessageMakerPort)


    def make_notify_message("1.0", from, to, content) do
        message = "version: 1.0\r\nto: #{to}\r\nfrom: #{from}\r\naction: notify\r\ntype: text\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        {:ok, message}
    end

end
