defmodule DeteccionElixir.Domain.Model.Fraud do
  @moduledoc """
  Fraud
  """

  @derive {Jason.Encoder, only: [:state, :client, :amount]}
  defstruct [:state, :client, :amount]

  def new(state, client, amount) do
    %__MODULE__{
      state: state,
      client: client,
      amount: amount
    }
  end
end
