# TestCard

![Test Card F](https://upload.wikimedia.org/wikipedia/en/5/52/Testcard_F.jpg)

Test card is an elixir application for testing pheonix channel clients.

It implements a simple chat server that client libraries can interact with, to
ensure their implementation works against an actual phoenix server.

#### Running

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).


#### Interacting

To run tests with TestCard a test must first create a user via the API. This
user can then join any of the channels that were listed in their topics.

When in a room, a client can send a variety of events:

- "ping" events will reply with the same payload as they received.
- "shout" events will send to all clients.
