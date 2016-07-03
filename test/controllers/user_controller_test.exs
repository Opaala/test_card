defmodule TestCard.UserControllerTest do
  use TestCard.ConnCase

  alias TestCard.{User, UserServer}
  @valid_attrs %{id: "test", rooms: ["test", "test2"]}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows chosen resource", %{conn: conn} do
    user = struct(User, @valid_attrs)
    {:ok, _pid} = UserServer.start_link(user)

    conn = get conn, user_path(conn, :show, user)
    assert json_response(conn, 200)["data"] == %{
      "id" => user.id,
      "rooms" => user.rooms
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    conn = get conn, user_path(conn, :show, -1)
    assert json_response(conn, 404)["errors"]["detail"]
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert UserServer.exists?(@valid_attrs.id)
    UserServer.stop(@valid_attrs.id)
  end

  test "deletes chosen resource", %{conn: conn} do
    user = struct(User, @valid_attrs)
    _server = UserServer.start_link(user)
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    refute UserServer.exists?(user.id)
  end
end
