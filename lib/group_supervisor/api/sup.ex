defmodule GroupSupervisor.API.Sup do
  @moduledoc """
  Supervisor router
  """

  use Maru.Router

  alias GroupSupervisor.Model.Group
  alias GroupSupervisor.Service.NodeMatcher

  namespace :sup do
    desc "Returns all known group supervisors"
    get :groups do
      groups = Group.find_all()
      conn |> put_status(200) |> json(%{groups: groups})
    end

    desc "Saves new group"
    params do
      requires :name, type: String
      requires :supervisor, type: String
    end
    post :join do
      group = %Group{name: params[:name], supervisor: params[:supervisor]}
      Group.save(group)
      conn |> put_status(200) |> json(group)
    end

    desc "Returns points (0-100) of node match"
    get :node_match do
      match = NodeMatcher.calculate_match()
      conn |> put_status(200) |> json(%{match: match})
    end
  end
end
