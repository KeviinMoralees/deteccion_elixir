defmodule DeteccionElixir.Application do
  @moduledoc """
  DeteccionElixir application
  """

  alias DeteccionElixir.Infrastructure.EntryPoint.ApiRest
  alias DeteccionElixir.Config.{AppConfig, ConfigHolder}

  use Application
  require Logger

  def start(_type, [env]) do
    config = AppConfig.load_config()

    # children =[{WebSocketExample, "wss://echo.websocket.org/"}]++  with_plug_server(config) ++ all_env_children(config) ++ env_children(env, config)
    children = with_plug_server(config) ++ all_env_children(config) ++ env_children(env, config)


    opts = [strategy: :one_for_one, name: DeteccionElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp with_plug_server(%AppConfig{enable_server: true, http_port: port}) do
    Logger.debug("Configure Http server in port #{inspect(port)}. ")
    [
      {Plug.Cowboy, scheme: :http, plug: ApiRest, options: [port: port]},
      {Plug.Cowboy, scheme: :http, plug: WebsocketServer.Plug, options: [port: 4000]}
    ]
  end

  defp with_plug_server(%AppConfig{enable_server: false}), do: []

  def all_env_children(%AppConfig{} = config) do
    [
      {ConfigHolder, config}
    ]
  end

  def env_children(:test, %AppConfig{}) do
    []
  end

  def env_children(_other_env, _config) do
    [
      {DeteccionElixir.Infrastructure.Adapters.Repository.Repo, []},
      {DeteccionElixir.Infrastructure.Adapters.Kafka.Kafka, []},

    ]
  end
end
