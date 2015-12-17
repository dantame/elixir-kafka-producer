defmodule ElixirKafkaProducer.DataController do
  use ElixirKafkaProducer.Web, :controller

  def index(conn, %{"topic" => topic, "data" => data}) do
    req_headers = conn.req_headers
    headers = req_headers
      |> Enum.filter(&extract_headers/1)
      |> Enum.into(%{})

    ip = conn.remote_ip
      |> Tuple.to_list
      |> Enum.join(".")

    now = :os.system_time(:seconds)

    augmented_data = Enum.into(headers, %{
      ip: ip,
      payload: Enum.into(data, %{ producerTimestamp: now })
    })

    KafkaEx.produce(topic, 0, Poison.encode!(augmented_data))
    text conn, "OK"
  end

  def index(conn, %{"topic" => topic}) do
    json conn, KafkaEx.fetch(topic, 0)
  end

  defp extract_headers({header, _}) do
    ["referer", "cookie", "user-agent"]
      |> Enum.any?(&(&1 == header))
  end
end
