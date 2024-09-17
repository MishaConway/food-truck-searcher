defmodule FoodTruckSearcher.FoodTrucksTest do
  alias FoodTruckSearcher.FoodTruckCategories
  alias FoodTruckSearcher.FoodTrucksCategories.FoodTruckCategory
  use FoodTruckSearcher.DataCase
  import FoodTruckSearcher.Fixtures

  describe "create" do
    test "successfully creates with name" do
      attrs = %{name: "burgers"}
      assert {:ok, food_truck_category} = FoodTruckCategories.create(attrs)

      # verify it returns back the expected category
      assert food_truck_category.name == attrs.name

      # verify it persists the expected category
      assert [persisted_category] = FoodTruckSearcher.Repo.all(FoodTruckCategory)
      assert persisted_category.name == attrs.name
    end

    test "errors when name is nil" do
      assert {:error, error} = FoodTruckCategories.create(%{name: nil})
      assert error.errors == [name: {"can't be blank", [validation: :required]}]
    end

    test "errors when category with name already exists" do
      existing_category = food_truck_category_fixture()
      assert {:error, error} = FoodTruckCategories.create(%{name: existing_category.name})

      assert error.errors == [
               name:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "food_truck_categories_name_index"]}
             ]
    end
  end

  describe "find_by_name" do
    test "finds category when it exists" do
      food_truck_category = food_truck_category_fixture()
      assert {:ok, found_category} = FoodTruckCategories.find_by_name(food_truck_category.name)
      assert found_category.id == food_truck_category.id
      assert found_category.name == food_truck_category.name
    end

    test "errors when category with name does not exist" do
      assert FoodTruckCategories.find_by_name("non existing name") == {:error, :not_found}
    end
  end
end
