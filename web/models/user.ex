defmodule TestCard.User do
  use TestCard.Web, :model
  defstruct [:id, :topics]
  use ExConstructor

  @type t :: %__MODULE__{
    id: String.t,
    topics: [String.t]
  }
end
