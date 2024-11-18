defmodule DeteccionElixir.ProcessMonitor do
  @moduledoc """
  Módulo para monitorear procesos en la aplicación.
  """

  def list_processes do
    Process.list()
    |> Enum.each(&IO.inspect(Process.info(&1)))
  end
end
