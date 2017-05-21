defmodule GroupSupervisor.Model.Group do
  @moduledoc false

  alias GroupSupervisor.Storage

  @type t :: %GroupSupervisor.Model.Group{}

  defstruct [:name, :supervisor]

  @doc """
  Creates struct from Map with string keys
  """
  @spec new(Map.t) :: t
  def new(%{"name" => name, "supervisor" => sup}) do
    %GroupSupervisor.Model.Group{name: name, supervisor: sup}
  end

  @doc """
  Finds all groups
  """
  @spec find_all() :: list(t)
  def find_all do
    key("*")
    |> Storage.find_all()
    |> Enum.map(&new(&1))
  end

  @doc """
  Finds group in storage by name
  """
  @spec find(String.t) :: {:ok, t} | :error
  def find(name) do
    with {:ok, data} <- name |> key() |> Storage.find() do
      {:ok, new(data)}
    end
  end

  @doc """
  Saves group into storage
  """
  @spec save(t) :: :ok | :error
  def save(%{name: name} = group) do
    name |> key() |> Storage.save(group)
  end

  @doc """
  Removes group from storage
  """
  @spec delete(t) :: :ok | :error
  def delete(%{name: name}) do
    delete(name)
  end

  @doc """
  Removes group from storage by name
  """
  @spec delete(String.t) :: :ok | :error
  def delete(name) do
    name |> key() |> Storage.delete()
  end

  defp key(name) do
    ["group", name] |> Enum.join(":")
  end
end
