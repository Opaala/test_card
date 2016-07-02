defmodule TestCard.Router do
  use TestCard.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TestCard do
    pipe_through :api
  end
end
