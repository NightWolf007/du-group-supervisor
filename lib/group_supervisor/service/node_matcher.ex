defmodule GroupSupervisor.Service.NodeMatcher do
  @moduledoc false

  alias Docker.Client

  @spec calculate_match() :: integer
  def calculate_match do
    nodes_count = Client.nodes() |> length()
    if nodes_count >= 2, do: 0, else: 100
  end
end
