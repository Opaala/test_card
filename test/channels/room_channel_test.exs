defmodule TestCard.RoomChannelTest do
  use TestCard.ChannelCase

  alias TestCard.{RoomChannel, UserServer, User}

  @user_id "room_channel_user"

  setup do
    {:ok, _pid} = UserServer.start_link(
      %User{id: @user_id, rooms: ["lobby", "other"]}
    )
    {:ok, _, socket} =
      socket("something", %{user_id: @user_id})
      |> subscribe_and_join(RoomChannel, "room:lobby")

    {:ok, socket: socket}
  end

  test "join returns payload" do
    {:ok, payload, _socket} =
      socket("something", %{user_id: @user_id})
      |> subscribe_and_join(RoomChannel, "room:other", %{"hello" => "there"})

    assert payload == %{"hello" => "there"}
  end

  test "join rejects unknown rooms" do
    {:error, %{reason: "unauthorized"}} =
      socket("something", %{user_id: @user_id})
      |> subscribe_and_join(RoomChannel, "room:test")
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
