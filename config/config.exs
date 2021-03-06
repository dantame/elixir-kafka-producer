# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elixir_kafka_producer, ElixirKafkaProducer.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "1wqnfXkZpXNWWizf+tia3jVJBbvmv0pRm40R8mMKtP6XfDgYiO1YHbsb24bWkZMR",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ElixirKafkaProducer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
