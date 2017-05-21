defmodule Docker.Client do
  @moduledoc false

  def join_token do
    ["swarm", "join-token", "-q", "worker"]
    |> docker()
    |> List.first
  end

  def nodes do
    docker(["node", "list", "-q"])
  end

  defp docker(cmd) do
    "docker"
    |> System.cmd(cmd)
    |> elem(0)
    |> String.split
  end
end
