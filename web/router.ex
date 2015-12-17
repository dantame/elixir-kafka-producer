defmodule ElixirKafkaProducer.Router do
  use ElixirKafkaProducer.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirKafkaProducer do
    pipe_through :api
    post "/", DataController, :index
    get "/", DataController, :index
  end
end
