defmodule WebsocketServer.Plug do
  use Plug.Router

  plug :match
  plug :dispatch

  # Ruta para el WebSocket
  match "/ws" do
    # Verificamos que la conexión sea un WebSocket válido
    if Plug.Conn.get_req_header(conn, "upgrade") == ["websocket"] do
      # Llamamos a Plug.Conn.upgrade_adapter/3 con el formato correcto
      conn
      |> Plug.Conn.upgrade_adapter(:websocket, {WebsocketServer.WebSocket, [], %{}})
    else
      send_resp(conn, 400, "Invalid WebSocket request")
    end
  end

  # Ruta básica
  get "/" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Welcome to the WebSocket server!")
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
