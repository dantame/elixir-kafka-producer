defmodule ElixirKafkaProducer.DataModel do
  defstruct ip: "unset",
            referer: "unset",
            cookie: "unset",
            "user-agent": "unset",
            payload: %{producerTimestamp: :os.system_time(:seconds)}

end
