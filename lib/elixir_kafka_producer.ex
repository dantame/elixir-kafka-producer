defmodule ElixirKafkaProducer do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    setup_kafka_hosts

    children = [
      # Start the endpoint when the application starts
      supervisor(ElixirKafkaProducer.Endpoint, []),
      worker(ErlangMonitor, [])
      # Here you could define other workers and supervisors as children
      # worker(ElixirKafkaProducer.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirKafkaProducer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirKafkaProducer.Endpoint.config_change(changed, removed)
    :ok
  end

  defp parse_broker({_, {broker, _}}) do
    parsed_broker = Poison.decode!(broker)
    {parsed_broker["host"], parsed_broker["port"]}
  end

  defp setup_kafka_hosts do
    {:ok, pid} = Zookeeper.Client.start(Application.get_env(:elixir_kafka_producer, :zookeeper_host))
    {:ok, broker_ids} = Zookeeper.Client.get_children(pid, "/brokers/ids")

    broker_hosts = broker_ids
      |> Enum.map(&(Zookeeper.Client.get(pid, "/brokers/ids/#{&1}")))
      |> Enum.map(&parse_broker/1)

    Application.put_env(:kafka_ex, :brokers, broker_hosts)

    KafkaEx.start(:normal, [])
  end
end
