defmodule FoodTruckSearcher.Repo.Migrations.CreateFoodTruckCategories do
  use Ecto.Migration

  def change do
    create table(:food_truck_categories) do
      add :name, :string, null: false
    end

    create unique_index(:food_truck_categories, :name)
  end
end
