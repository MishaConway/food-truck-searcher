defmodule FoodTruckSearcher.FoodTrucks.FoodTruck do
  @moduledoc "Module for FoodTruck schema"
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_trucks" do
    field :name, :string
    field :approved, :boolean
    field :zipcode, :string
    field :description, :string
    belongs_to(:food_truck_category, FoodTruckSearcher.FoodTrucksCategories.FoodTruckCategory)
    timestamps()
  end

  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, [
      :name,
      :approved,
      :zipcode,
      :description,
      :food_truck_category_id
    ])
    |> validate_required([:name, :approved, :food_truck_category_id])
    |> unique_constraint(:name)
  end
end
