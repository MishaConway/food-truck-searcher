defmodule FoodTruckSearcher.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  def change do
    create table(:food_trucks) do
      add :name, :string, null: false, indexed: true
      add :approved, :boolean, null: false
      add :food_truck_category_id, references(:food_truck_categories), null: false
      add :zipcode, :string, null: true, indexed: true
      add :description, :text
      timestamps()
    end

    create unique_index(:food_trucks, :name)
    create index(:food_trucks, :food_truck_category_id)
    create index(:food_trucks, :zipcode)
  end
end
