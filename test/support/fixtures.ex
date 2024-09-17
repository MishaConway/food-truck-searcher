defmodule FoodTruckSearcher.Fixtures do
  def food_truck_category_fixture(attrs \\ %{}) do
    {name, _} = Map.pop(attrs, :name)

    {:ok, food_truck_category} =
      FoodTruckSearcher.FoodTruckCategories.create(%{name: name || "some name"})

    food_truck_category
  end

  def food_truck_fixture(attrs \\ %{}) do
    {category, _} = Map.pop(attrs, :food_truck_category)
    category = category || food_truck_category_fixture()

    approved =
      if Map.has_key?(attrs, :approved),
        do: attrs.approved,
        else: true

    attrs = %{
      name: attrs[:name] || Faker.Team.name(),
      approved: approved,
      food_truck_category_id: category.id,
      description: attrs[:description] || Faker.Lorem.sentence(),
      zipcode: attrs[:zipcode] || to_string(Faker.random_between(1, 10_000_000))
    }

    {:ok, food_truck} =
      FoodTruckSearcher.FoodTrucks.create(attrs)

    food_truck
  end
end
