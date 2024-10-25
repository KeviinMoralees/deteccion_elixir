import Config

config :deteccion_elixir,
  timezone: "America/Bogota",
  env: :dev,
  http_port: 8084,
  enable_server: true,
  version: "0.0.1",
  custom_metrics_prefix_name: "deteccion_elixir_local"

config :logger,
  level: :debug

config :deteccion_elixir, ecto_repos: [DeteccionElixir.Infrastructure.Adapters.Repository.Repo,]
config :deteccion_elixir, DeteccionElixir.Infrastructure.Adapters.Repository.Repo,
  database: "frauds_db",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10,
  telemetry_prefix: [:elixir, :repo]

config :kafka_ex,
  brokers: [{"localhost", 9092}],
  consumer_group: "my_consumer_group",
  disable_default_worker: false
