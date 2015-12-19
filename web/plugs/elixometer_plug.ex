defmodule ElixometerPlug do
  @behaviour Plug

  import Plug.Conn, only: [register_before_send: 2]
  use Elixometer

  def init(opts), do: opts

  def call(conn, _config) do
    before_timestamp = :os.timestamp

    register_before_send conn, fn(conn) ->
      after_timestamp = :os.timestamp
      diff = :timer.now_diff after_timestamp, before_timestamp

      update_histogram("response.time", diff)
      update_spiral("response.count", 1)
      conn
    end
  end
end
