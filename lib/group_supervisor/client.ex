defmodule GroupSupervisor.Client do
  @moduledoc false
  use HTTPoison.Base

  def sup_groups(host) do
    host |> build_url("/sup/groups") |> get()
  end

  def sup_join(host, group) do
    host |> build_url("/sup/join") |> post(group, [{"Content-Type", "application/json"}])
  end

  def sup_node_match(host) do
    host |> build_url("/sup/node_match") |> get()
  end

  def process_request_body(body), do: Poison.encode!(body)

  def process_response_body(body), do: Poison.decode!(body)

  defp build_url(host, path) do
    "http://" <> host <> ":10000" <> path
  end
end
