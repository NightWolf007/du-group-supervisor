defmodule GroupSupervisor.Client do
  @moduledoc false
  use HTTPoison.Base

  def sup_node_match(host) do
    get(host <> "/sup/node_match")
  end

  def process_request_body(body), do: Poison.encode!(body)

  def process_response_body(body), do: Poison.decode!(body)
end
