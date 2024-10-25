import Config

config :deteccion_elixir,
  timezone: "America/Bogota",
  env: :prod,
  http_port: 8083,
  enable_server: true,
  version: "0.0.1",
  custom_metrics_prefix_name: "deteccion_elixir"

config :logger,
  level: :warning

config :deteccion_elixir, DeteccionElixir.Infrastructure.Adapters.Repository.Repo,
  database: "",
  username: "",
  password: "",
  hostname: "",
  pool_size: 10,
  telemetry_prefix: [:elixir, :repo]
