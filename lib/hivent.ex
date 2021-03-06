defmodule Hivent do
  @moduledoc """
  The main Hivent application. It starts both a Consumer and an Emitter process.
  """
  use Application
  alias Hivent.{Config, Emitter}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    server_config = Config.get(:hivent, :server)

    children = [
      worker(Emitter, [[
        host: server_config[:host],
        port: server_config[:port],
        path: "/producer/websocket",
        secure: server_config[:secure],
        client_id: Config.get(:hivent, :client_id),
        api_key: server_config[:api_key]
      ]])
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Hivent)
  end

  def emit(name, payload, options), do: Emitter.emit(name, payload, options)
end
