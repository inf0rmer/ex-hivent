defmodule Hivent.Redis do
  @moduledoc """
  The Hivent Redis process.
  """

  def start_link(name, uri) do
    client = Exredis.start_using_connection_string(uri)
    true = Process.register(client, name)
    {:ok, client}
  end
end