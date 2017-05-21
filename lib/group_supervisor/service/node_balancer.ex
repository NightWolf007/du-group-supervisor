defmodule GroupSupervisor.Service.NodeBalancer do
  @moduledoc false

  alias GroupSupervisor.Model.Group
  alias GroupSupervisor.Client

  def find_group do
    Group.find_all()
    |> Enum.map(fn (grp) -> {grp, Client.sup_node_match(grp.supervisor)} end)
    |> Enum.map(fn ({sup, {:ok, resp}}) -> {sup, resp} end)
    |> Enum.map(fn ({sup, %{body: body}}) -> {sup, body} end)
    |> Enum.map(fn ({sup, %{"match" => match}}) -> {sup, match} end)
    |> Enum.max_by(&elem(&1, 1), fn -> {nil, 0} end)
    |> check_match()
    |> elem(0)
  end

  defp check_match({_, 0}), do: {nil, 0}
  defp check_match({grp, match}), do: {grp, match}
end
