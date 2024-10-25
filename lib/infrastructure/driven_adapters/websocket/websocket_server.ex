defmodule WebsocketServer.WebSocket do
  @behaviour :cowboy_websocket

  def init(req, state) do
    {:ok, pid} = Agent.start_link(fn -> self() end, name: :websocket_pid)
    {:cowboy_websocket, req, state}
  end

  def websocket_init(state) do
    {:ok, state}
  end

  def websocket_handle({:text, msg}, state) do
    IO.puts("Received message: #{msg}")
    {:reply, {:text, "Echo: " <> msg}, state}
  end

  
  def websocket_handle(_frame, state) do
    {:ok, state}
  end

  def websocket_info({:send_message, message}, state) do
    {:reply, {:text, message}, state}
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
