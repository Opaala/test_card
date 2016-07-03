defmodule TestCard.UserServerTest do
  use ExUnit.Case

  alias TestCard.{UserServer, User}

  @id "user_server_test"

  setup do
    {:ok, _pid} = UserServer.start_link(%User{id: @id, rooms: ["lobby", "test"]})

    {:ok, %{}}
  end

  test "room_allowed?" do
    assert UserServer.room_allowed?(@id, "lobby")
    assert UserServer.room_allowed?(@id, "test")
    refute UserServer.room_allowed?(@id, "nope")
  end
end
