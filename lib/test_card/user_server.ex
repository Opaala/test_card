defmodule TestCard.UserServer do
  alias TestCard.User

  @type user_id :: TestCard.User.t | String.t

  @spec start_link(TestCard.User.t) :: {:ok, pid}
  def start_link(user) do
    Agent.start_link(fn -> user end, name: name(user))
  end


  @doc """
  Stops the UserServer for the given user.
  """
  @spec stop(user_id) :: :ok
  def stop(user) do
    user |> name |> Agent.stop
  end

  @doc """
  Checks if a user exists
  """
  @spec exists?(user_id) :: boolean
  def exists?(user) do
    case user |> gproc_name |> :gproc.lookup_pids do
      [] -> false
      _ -> true
    end
  end

  @spec get(user_id) :: User.t
  def get(user) do
    user |> name |> Agent.get(fn x -> x end)
  end

  @doc """
  Checks if the given topic is allowed for a user.
  """
  @spec topic_allowed?(user_id, String.t) :: boolean
  def topic_allowed?(user, topic) do
    user |> name |> Agent.get(fn %User{topics: topics} ->
      Enum.find(topics, &(&1 == topic)) != nil
    end)
  end

  @spec name(user_id) :: {atom, atom, :gproc.key}
  defp name(name), do: {:via, :gproc, gproc_name(name)}

  @spec gproc_name(user_id) :: :grpoc.key
  defp gproc_name(%User{id: id}), do: gproc_name(id)
  defp gproc_name(name), do: {:n, :l, name}
end
