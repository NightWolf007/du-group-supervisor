defmodule GroupSupervisor do
  @moduledoc false

  alias GroupSupervisor.Model.Group
  alias GroupSupervisor.Client

  def start(_type, _args) do
    group = Group.new(supervisor())
    Group.save(group)
    if !is_nil(System.get_env("JOIN")), do: join(group)
    Maru.Supervisor.start_link()
  end

  defp join(grp) do
    host = System.get_env("JOIN")
    {:ok, %{body: %{"groups": resp_groups}}} = Client.sup_groups(host)
    groups = Enum.map(resp_groups, &Group.from_hash(&1))
    Enum.each(groups, &Group.save(&1))
    Enum.each(groups, fn (%{supervisor: sup}) -> Client.sup_join(sup, grp) end)
  end

  defp supervisor do
    "#{hostname()}:10000"
  end

  defp hostname do
    System.get_env("HOSTNAME")
  end
end
