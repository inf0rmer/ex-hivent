defmodule Hivent.Event do
  @moduledoc """
  Defines a Hivent Event struct.
  """
  @derive [Poison.Encoder]

  defmodule Meta do
    @moduledoc false
    @derive [Poison.Encoder]
    defstruct [:name, :producer, :version, :cid, :uuid, :created_at, :key]
  end

  defstruct meta: Meta.__struct__, payload: %{}, name: nil
end
