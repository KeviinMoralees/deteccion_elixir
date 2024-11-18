defmodule WebsocketServer.WebSocket do
  @behaviour :cowboy_websocket

  # # Inicia el WebSocket y almacena su PID
  # def init(req, state) do
  #   # Almacenar el PID del WebSocket en un agente
  #   Agent.update(:websocket_pid, fn _ -> self() end)
  #   {:cowboy_websocket, req, state}
  # end

  # # Inicializa el WebSocket
  # def websocket_init(state) do
  #   {:ok, state}
  # end

  # Maneja mensajes de texto entrantes
  def websocket_handle({:text, msg}, state) do
    IO.puts("Received message: #{msg} from PID: #{inspect(self())}")
    {:reply, {:text, "Echo: " <> msg}, state}
  end

  # Maneja otros tipos de mensajes de WebSocket
  def websocket_handle(_frame, state) do
    {:ok, state}
  end

  # Maneja mensajes enviados a este WebSocket
  def websocket_info({:send_message, message}, state) do
    {:reply, {:text, message}, state}
  end

  # Maneja información no reconocida
  def websocket_info(_info, state) do
    {:ok, state}
  end

  # Limpieza al terminar
  def terminate(_reason, _req, _state) do
    :ok
  end

  # Función para enviar mensajes al WebSocket
  def send_message(message) do
    Process.send(self(), {:send_message, message}, [])
  end
end
