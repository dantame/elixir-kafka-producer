defmodule ElixirKafkaProducer.Router do
  use ElixirKafkaProducer.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :monitoring do
    plug ElixometerPlug
  end

  scope "/", ElixirKafkaProducer do
    pipe_through :api
    pipe_through :monitoring
    post "/", DataController, :index
    get "/", DataController, :index
  end
end
