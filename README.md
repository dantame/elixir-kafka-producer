# ElixirKafkaProducer

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Usage

- Run the server
- POST json to "/" in the following format:

{
  "topic": "whatever-topic-you-want",
  "data": "data is cool"
}

- GET on "/?topic=whatever-topic-you-want" will return all of the data currently in kafka for a particular topic

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
