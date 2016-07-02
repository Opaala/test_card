defmodule TestCard.UserView do
  use TestCard.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, TestCard.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, TestCard.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      topics: user.topics}
  end
end
