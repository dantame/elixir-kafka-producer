use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :elixir_kafka_producer, ElixirKafkaProducer.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: []

config :elixir_kafka_producer, zookeeper_host: "localhost:2181"
config :kafka_ex, brokers: []
config :elixometer, reporter: ElixirKafkaProducer.Reporter, env: Mix.env, metric_prefix: "ElixirKafkaProducer", update_frequency: 1000

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20
