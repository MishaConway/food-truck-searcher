defmodule FoodTruckSearcher.FoodTrucksCategories.FoodTruckCategory do
  @moduledoc "Module for FoodTruckCategory schema"
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_truck_categories" do
    field :name, :string
  end

  def changeset(food_truck_category, attrs) do
    food_truck_category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
