defmodule Hivent do
  @moduledoc """
  The main Hivent application. It starts an Agent that holds a persistent
  connection to the Redis backend.
  """
  use Application
  alias Hivent.{Emitter, Redis, Config}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Redis, [:redis, Config.get(:hivent, :endpoint)]),
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Hivent)
  end

  def emit(name, payload, %{key: _} = options) do
    redis
    |> Emitter.emit(name, payload, options)
  end

  def redis do
    Process.whereis(:redis)
  end
end
