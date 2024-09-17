defmodule FoodTruckSearcher.FoodTruckCategories do
  alias FoodTruckSearcher.FoodTrucksCategories.FoodTruckCategory
  import Ecto.Query

  @spec create(map()) :: {:ok, FoodTruckCategory.t()} | {:error, Ecto.Changeset.t()}
  def create(attrs) do
    %FoodTruckCategory{}
    |> FoodTruckCategory.changeset(attrs)
    |> FoodTruckSearcher.Repo.insert()
  end

  @spec find_by_name(String.t()) :: {:ok, FoodTruckCategory.t()} | {:error, :not_found}
  def find_by_name(name) when is_binary(name) do
    FoodTruckCategory
    |> where([category], category.name == ^name)
    |> FoodTruckSearcher.Repo.one()
    |> case do
      %FoodTruckCategory{} = category -> {:ok, category}
      nil -> {:error, :not_found}
    end
  end
end
