defmodule GroupSupervisor.API.Node do
  @moduledoc """
  Node router
  """

  use Maru.Router

  alias Docker.Client
  alias GroupSupervisor.Service.NodeBalancer

  namespace :nodes do
    desc "Returns group to join for node"
    get :group do
      group = NodeBalancer.find_group()
      conn |> put_status(200) |> json(%{group: group})
    end

    desc "Joins node to group"
    get :join do
      token = Client.join_token()
      conn |> put_status(200) |> json(%{swarm_token: token})
    end
  end
end
