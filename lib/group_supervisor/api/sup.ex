defmodule GroupSupervisor.API.Sup do
  @moduledoc """
  Supervisor router
  """

  use Maru.Router

  alias GroupSupervisor.Model.Group
  alias GroupSupervisor.Service.NodeMatcher

  namespace :sup do
    desc "Returns all known group supervisors"
    get :join do
      groups = Group.find_all()
      conn |> put_status(200) |> json(%{groups: groups})
    end

    desc "Returns points (0-100) of node match"
    get :node_match do
      match = NodeMatcher.calculate_match()
      conn |> put_status(200) |> json(%{match: match})
    end
  end
end
