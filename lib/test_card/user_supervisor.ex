defmodule TestCard.UserSupervisor do
  @moduledoc """
  Simple one for one supervisor for user processes.
  """
  use Supervisor

  @spec start_link() :: {:ok, pid}
  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Starts a UserServer for the given user.
  """
  @spec add_user(TestCard.User.t) :: Supervisor.on_start_child
  def add_user(user) do
    Supervisor.start_child(__MODULE__, [user])
  end

  @doc """
  Stops the UserServer for the given user
  """
  @spec remove_user(TestCard.user_id) :: :ok
  def remove_user(user) do
    TestCard.UserServer.stop(user)
  end

  def init([]) do
    children = [worker(TestCard.UserServer, [], restart: :transient)]

    supervise(children, strategy: :simple_one_for_one)
  end
end
