defmodule TestCard.RoomChannel do
  use TestCard.Web, :channel

  def join("room:" <> room, payload, socket) do
    if authorized?(room, socket.assigns.user_id) do
      {:ok, payload, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(room, user) do
    alias TestCard.UserServer
    UserServer.exists?(user) and UserServer.room_allowed?(user, room)
  end
end
