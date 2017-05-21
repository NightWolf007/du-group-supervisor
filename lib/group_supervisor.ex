defmodule GroupSupervisor do
  @moduledoc false

  alias GroupSupervisor.Model.Group

  def start(_type, _args) do
    if System.get_env("FIRST_GS") == "1", do: on_first_gs()
    Maru.Supervisor.start_link()
  end

  defp on_first_gs do
    hostname = System.get_env("HOSTNAME")
    grp = %Group{name: "group1", supervisor: "http://#{hostname}:10000"}
    Group.save(grp)
  end
end
