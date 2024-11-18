defmodule DeteccionElixir.Infrastructure.Adapters.Kafka.Kafka do
  use GenServer
  require Logger
  alias KafkaEx.Protocol.Fetch.Message

  @topic "transaction_topic"
  @consumer_group "my_consumer_group"



  # Iniciar el GenServer
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Definir el child_spec para el supervisor
  def child_spec(opts) do
      
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  # Inicializar el estado del GenServer
  def init(_opts) do
    Logger.info("Iniciando consumidor de Kafka para el tópico #{@topic}...")

    # Crear un worker para KafkaEx
    KafkaEx.create_worker(__MODULE__, consumer_group: @consumer_group)

    # En lugar de `subscribe/1`, usaremos un stream para leer mensajes
    # Iniciamos la lectura de mensajes en el tópico
    stream_messages(@topic)

    {:ok, %{}}
  end

  # Usamos KafkaEx.stream/2 para leer mensajes de Kafka en un stream
  defp stream_messages(topic) do
    Task.start(fn ->
      KafkaEx.stream(topic, 0)
      |> Enum.each(fn %Message{value: message_value} ->
        IO.puts("Mensaje x recibido de Kafka: #{message_value}")
      end)
    end)
  end

  # Escuchar mensajes de Kafka (este puede no ser necesario si usamos `stream_messages`)
  def handle_info({:kafka_message, message}, state) do
    IO.puts("Mensaje recibido de Kafka: #{inspect(message.value)}")
    {:noreply, state}
  end

  # Función para simular la recepción de un mensaje (para pruebas)
  def simulate_kafka_message do
    send(
      __MODULE__,
      {:kafka_message, %Message{value: "Mensaje de prueba"}}
    )
  end
end
