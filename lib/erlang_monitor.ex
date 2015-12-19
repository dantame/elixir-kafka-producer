defmodule ErlangMonitor do
  use GenServer
  use Elixometer

  @polling_interval 1_000

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    schedule_work
    {:ok, []}
  end

  def handle_info(:work, state) do
    state = do_work(state)
    schedule_work
    {:noreply, state}
  end

  defp do_work(state) do
    update_metrics
    state
  end

  defp schedule_work do
    Process.send_after(self, :work, @polling_interval)
  end

  defp update_metrics do
    memory = :erlang.memory
    run_queue = :erlang.statistics(:run_queue)
    io = :erlang.statistics(:io) |> Tuple.to_list |> Enum.into(%{})

    update_gauge("memory.total", memory[:total])
    update_gauge("memory.proceses", memory[:processes])
    update_gauge("memory.system", memory[:system])
    update_gauge("memory.atom", memory[:atom])
    update_gauge("memory.code", memory[:code])
    update_gauge("memory.ets", memory[:ets])

    update_gauge("io.input", io[:input])
    update_gauge("io.output", io[:output])

    update_gauge("run_queue", run_queue)
  end
end
