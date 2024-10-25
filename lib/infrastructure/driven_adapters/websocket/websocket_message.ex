defmodule WebsocketServer.MessageSender do
  def send_message(pid, message) do
    Process.send(pid, {:send_message, message}, [])
  end
end
