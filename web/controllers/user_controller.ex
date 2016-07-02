defmodule TestCard.UserController do
  use TestCard.Web, :controller

  alias TestCard.{User, UserSupervisor, UserServer}

  def create(conn, %{"user" => user_params}) do
    user = user_params |> TestCard.User.new
    UserSupervisor.add_user(user)
    conn |> put_status(:created) |> render("show.json", user: user) 
  end

  def show(conn, %{"id" => id}) do
    if UserServer.exists?(id) do
      user = UserServer.get(id)
      render(conn, "show.json", user: user)
    else
      conn |> put_status(:not_found) |> render(TestCard.ErrorView, "404.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = UserSupervisor.remove_user(id)
    send_resp(conn, :no_content, "")
  end
end
