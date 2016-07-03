defmodule TestCard.User do
  use TestCard.Web, :model
  defstruct [:id, :rooms]
  use ExConstructor

  @type t :: %__MODULE__{
    id: String.t,
    rooms: [String.t]
  }
end
