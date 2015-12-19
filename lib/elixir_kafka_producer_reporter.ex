defmodule ElixirKafkaProducer.Reporter do
    # exometer callbacks
    def exometer_init(_opts) do
      {:ok, nil}
    end

    def exometer_newentry(_entry, state) do
      {:ok, state}
    end

    def exometer_report(metric, datapoint, extra, value,  state) do
      {:ok, state}
    end

    def exometer_subscribe(_name, _metric, _timeout, _opts, state) do
      {:ok, state}
    end

    def exometer_info(_cmd, state) do
      {:ok, state}
    end
 end
