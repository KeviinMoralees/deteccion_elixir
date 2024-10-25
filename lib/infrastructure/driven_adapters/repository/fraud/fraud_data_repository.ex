defmodule DeteccionElixir.Infrastructure.Adapters.Repository.Fraud.FraudDataRepository do
  alias DeteccionElixir.Infrastructure.Adapters.Repository.Repo
  alias DeteccionElixir.Infrastructure.Adapters.Repository.Fraud.Data.FraudData
  # alias DeteccionElixir.Domain.Model.Fraud

  ## TODO: Update behaviour
  # @behaviour DeteccionElixir.Domain.Behaviours.FraudBehaviour

  def find_by_id(id), do: FraudData |> Repo.get(id) |> to_entity

  def insert(entity) do
    case to_data(entity) |> Repo.insert() do
      {:ok, entity} -> entity |> to_entity()
      error -> error
    end
  end

  defp to_entity(nil), do: nil

  defp to_entity(data) do
    ## TODO: Update Entity
    # struct(Fraud, data |> Map.from_struct)
    %{}
  end

  defp to_data(entity) do
    struct(FraudData, entity |> Map.from_struct())
  end
end
