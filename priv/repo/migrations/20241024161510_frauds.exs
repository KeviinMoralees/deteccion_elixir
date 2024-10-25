defmodule DeteccionElixir.Infrastructure.Adapters.Repository.Repo.Migrations.Frauds do
  use Ecto.Migration

  def change do
    create table(:frauds) do
      add :state, :string
      add :client, :string
      add :amount, :decimal
    end
  end
end
