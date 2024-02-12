defmodule Snap.Utils do
  def remove_unloaded_associations(struct) when is_map(struct) do
    struct
    |> Map.from_struct()
    |> Enum.reduce(%{}, fn
      {_key, %Ecto.Association.NotLoaded{}}, acc -> acc
      {key, value}, acc -> Map.put(acc, key, remove_unloaded_associations(value))
    end)
  end

  def remove_unloaded_associations(list) when is_list(list) do
    Enum.map(list, &remove_unloaded_associations/1)
  end

  def remove_unloaded_associations(value), do: value
end
