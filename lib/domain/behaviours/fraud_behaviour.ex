defmodule DeteccionElixir.Domain.Behaviours.FraudBehaviour do
  @moduledoc """
  FraudBehaviour
  """
  @callback sendclient_or_savedb(map()) :: {:ok, term()}  | {:error, term()}
  # @callback replace_function_name(param_one::term, param_two::term)::{:ok, true::term} | {:error, reason::term}
end
