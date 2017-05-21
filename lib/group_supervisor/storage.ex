defmodule GroupSupervisor.Storage do
  @moduledoc """
  Provides functions for managing storage
  """

  import Exredis.Api

  @doc """
  Finds data by pattern
  """
  @spec find_all(String.t) :: list(Map.t)
  def find_all(pattern) do
    pattern
    |> keys()
    |> Enum.map(&get(&1))
    |> Enum.map(&decode(&1))
  end

  @doc """
  Finds data by key
  """
  @spec find(String.t) :: {:ok, Map.t} | :error
  def find(key) do
    case key |> get() do
      :undefined -> :error
      data -> {:ok, decode(data)}
    end
  end

  @doc """
  Saves data by key
  """
  @spec save(String.t, Map.t) :: :ok | :error
  def save(key, data) do
    key |> set(encode(data))
  end

  @doc """
  Removes data by key
  """
  @spec delete(String.t) :: :ok | :error
  def delete(key) do
    if key |> del() > 0, do: :ok, else: :error
  end

  defp encode(data) do
    Poison.encode!(data)
  end

  defp decode(data) do
    Poison.decode!(data)
  end
end
