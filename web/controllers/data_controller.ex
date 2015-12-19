defmodule ElixirKafkaProducer.DataController do
  use ElixirKafkaProducer.Web, :controller

  def index(conn, %{"topic" => topic, "data" => data}) do
    augmented_data = augment_data(conn, data)

    KafkaEx.produce(topic, 0, Poison.encode!(augmented_data))
    text conn, "OK"
  end

  def index(conn, %{"topic" => topic}) do
    json conn, KafkaEx.fetch(topic, 0)
  end

  defp augment_data(conn, data) do
    ip = conn.remote_ip
      |> Tuple.to_list
      |> Enum.join(".")

    now = :os.system_time(:seconds)

    payload = data
      |> Enum.into(%{producerTimestamp: now})

    conn.req_headers
      |> Enum.filter(&extract_headers/1)
      |> Enum.into(%{})
      |> Map.merge(%ElixirKafkaProducer.DataModel{ip: ip, payload: payload})
  end

  defp extract_headers({header, _}) do
    ["referer", "cookie", "user-agent"]
      |> Enum.any?(&(&1 == header))
  end
end
