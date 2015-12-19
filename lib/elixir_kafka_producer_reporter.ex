defmodule ElixirKafkaProducer.Reporter do
    # exometer callbacks
    def exometer_init(_opts) do
      {:ok, nil}
    end

    def exometer_newentry(_entry, state) do
      {:ok, state}
    end

    def exometer_report(_, datapoint = :ms_since_reset, _, _, state), do: {:ok, state}

    def exometer_report(metric, datapoint, extra, value,  state) do
      #Uncomment this line to push stats out to console
      #IO.inspect {metric, datapoint, extra, value, state}
      {:ok, state}
    end


    def exometer_subscribe(_name, _metric, _timeout, _opts, state) do
      {:ok, state}
    end

    def exometer_info(_cmd, state) do
      {:ok, state}
    end
 end
