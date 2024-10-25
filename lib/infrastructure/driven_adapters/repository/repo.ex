defmodule DeteccionElixir.Infrastructure.Adapters.Repository.Repo do
  use Ecto.Repo,
    otp_app: :deteccion_elixir,
    adapter: Ecto.Adapters.Postgres
end
