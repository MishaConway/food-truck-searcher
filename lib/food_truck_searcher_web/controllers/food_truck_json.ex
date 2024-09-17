defmodule FoodTruckSearcherWeb.FoodTruckJSON do
  alias FoodTruckSearcher.FoodTrucks.FoodTruck

  def index(%{food_trucks: food_trucks}) do
    for(food_truck <- food_trucks, do: data(food_truck))
  end

  defp data(%FoodTruck{} = food_truck) do
    # todo: preload this in query to avoid n+1 queries
    food_truck = FoodTruckSearcher.Repo.preload(food_truck, :food_truck_category)
    %{
      name: food_truck.name,
      approved: food_truck.approved,
      zipcode: food_truck.zipcode,
      description: food_truck.description,
      category: food_truck.food_truck_category.name
    }
  end
end