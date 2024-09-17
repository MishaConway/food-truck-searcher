defmodule FoodTruckSearcher.FoodTrucksTest do
  alias FoodTruckSearcher.FoodTrucks
  use FoodTruckSearcher.DataCase
  import FoodTruckSearcher.Fixtures

  describe "create" do
    setup do
      food_truck_category = food_truck_category_fixture()

      valid_attrs = %{
        name: "some name",
        approved: true,
        food_truck_category_id: food_truck_category.id,
        description: "some description",
        zipcode: "90043"
      }

      {:ok, %{attrs: valid_attrs, food_truck_category: food_truck_category}}
    end

    test "successfully creates with valid attributes", ctx do
      assert {:ok, food_truck} = FoodTrucks.create(ctx.attrs)
      food_truck = FoodTruckSearcher.Repo.preload(food_truck, [:food_truck_category])
      assert food_truck.name == ctx.attrs.name
      assert food_truck.approved == ctx.attrs.approved
      assert food_truck.food_truck_category.id == ctx.attrs.food_truck_category_id
      assert food_truck.description == ctx.attrs.description
      assert food_truck.zipcode == ctx.attrs.zipcode
    end

    test "fails when name is missing", ctx do
      attrs = Map.delete(ctx.attrs, :name)
      assert {:error, error} = FoodTrucks.create(attrs)
      assert error.errors == [name: {"can't be blank", [validation: :required]}]
    end

    test "fails when approved is missing", ctx do
      attrs = Map.delete(ctx.attrs, :approved)
      assert {:error, error} = FoodTrucks.create(attrs)
      assert error.errors == [approved: {"can't be blank", [validation: :required]}]
    end

    test "fails when food_truck_category_id is missing", ctx do
      attrs = Map.delete(ctx.attrs, :food_truck_category_id)
      assert {:error, error} = FoodTrucks.create(attrs)
      assert error.errors == [food_truck_category_id: {"can't be blank", [validation: :required]}]
    end

    test "fails when another food truck already exists with the same name", ctx do
      assert {:ok, _} = FoodTrucks.create(ctx.attrs)
      assert {:error, error} = FoodTrucks.create(ctx.attrs)

      assert error.errors == [
               name:
                 {"has already been taken",
                  [{:constraint, :unique}, {:constraint_name, "food_trucks_name_index"}]}
             ]
    end
  end

  describe "find_by_name" do
    test "finds food truck when it exists" do
      food_truck = food_truck_fixture()
      assert {:ok, found_food_truck} = FoodTrucks.find_by_name(food_truck.name)
      assert found_food_truck.id == food_truck.id
      assert found_food_truck.name == food_truck.name
    end

    test "errors when category with name does not exist" do
      assert FoodTrucks.find_by_name("non existing name") == {:error, :not_found}
    end
  end

  describe "search" do
    setup do
      truck_category = food_truck_category_fixture(%{name: "Truck"})
      push_cart_category = food_truck_category_fixture(%{name: "Push Cart"})

      {:ok, %{truck_category: truck_category, push_cart_category: push_cart_category}}
    end

    test "searches by approved", ctx do
      # make 3 approved food trucks
      num_approved = 3

      for _i <- 1..3 do
        food_truck_fixture(%{approved: true, food_truck_category: ctx.truck_category})
      end

      # make 2 not approved food trucks
      for _i <- 1..2 do
        food_truck_fixture(%{approved: false, food_truck_category: ctx.truck_category})
      end

      assert {:ok, food_trucks} =
               FoodTrucks.search(
                 FoodTruckSearcher.FoodTrucks.SearchParams.new(%{
                   include_approved: true,
                   include_not_approved: false
                 })
               )

      for food_truck <- food_trucks do
        assert food_truck.approved
      end

      assert length(food_trucks) == num_approved
    end

    test "searches by NOT approved", ctx do
      # make 3 not approved food trucks
      num_not_approved = 3

      for _i <- 1..3 do
        food_truck_fixture(%{approved: false, food_truck_category: ctx.truck_category})
      end

      # make 2 approved food trucks
      for _i <- 1..2 do
        food_truck_fixture(%{approved: true, food_truck_category: ctx.truck_category})
      end

      assert {:ok, food_trucks} =
               FoodTrucks.search(
                 FoodTruckSearcher.FoodTrucks.SearchParams.new(%{
                   include_approved: false,
                   include_not_approved: true
                 })
               )

      for food_truck <- food_trucks do
        refute food_truck.approved
      end

      assert length(food_trucks) == num_not_approved
    end

    test "searches by truck category", ctx do
      # make 3 truck
      num_truck = 3

      for _i <- 1..3 do
        food_truck_fixture(%{food_truck_category: ctx.truck_category})
      end

      # make 2 push cart
      for _i <- 1..2 do
        food_truck_fixture(%{food_truck_category: ctx.push_cart_category})
      end

      assert {:ok, food_trucks} =
               FoodTrucks.search(
                 FoodTruckSearcher.FoodTrucks.SearchParams.new(%{
                   include_truck_category: true,
                   include_push_cart_category: false
                 })
               )

      for food_truck <- food_trucks do
        assert food_truck.food_truck_category_id == ctx.truck_category.id
      end

      assert length(food_trucks) == num_truck
    end

    test "searches by push cart category", ctx do
      # make 3 push cart
      num_push_cart = 3

      for _i <- 1..3 do
        food_truck_fixture(%{food_truck_category: ctx.push_cart_category})
      end

      # make 2 truck
      for _i <- 1..2 do
        food_truck_fixture(%{food_truck_category: ctx.truck_category})
      end

      assert {:ok, food_trucks} =
               FoodTrucks.search(
                 FoodTruckSearcher.FoodTrucks.SearchParams.new(%{
                   include_truck_category: false,
                   include_push_cart_category: true
                 })
               )

      for food_truck <- food_trucks do
        assert food_truck.food_truck_category_id == ctx.push_cart_category.id
      end

      assert length(food_trucks) == num_push_cart
    end

    test "searches by zipcode", ctx do
      # make 3 90210 zipcode trucks
      num_90210 = 3

      for _i <- 1..3 do
        food_truck_fixture(%{zipcode: "90210", food_truck_category: ctx.truck_category})
      end

      # make 2 44070 zipcode trucks
      for _i <- 1..2 do
        food_truck_fixture(%{zipcode: "44070", food_truck_category: ctx.truck_category})
      end

      assert {:ok, food_trucks} =
               FoodTrucks.search(
                 FoodTruckSearcher.FoodTrucks.SearchParams.new(%{
                   zipcode: "90210"
                 })
               )

      for food_truck <- food_trucks do
        assert food_truck.zipcode == "90210"
      end

      assert length(food_trucks) == num_90210
    end

    test "searches by search text", ctx do
      num_burger_trucks = 3

      # make 3 food trucks referencing burgers
      food_truck_fixture(%{description: "burgers steaks", food_truck_category: ctx.truck_category})

      food_truck_fixture(%{
        description: "fries and burgers",
        food_truck_category: ctx.truck_category
      })

      food_truck_fixture(%{
        description: "shakes and things and also burgers",
        food_truck_category: ctx.truck_category
      })

      # make 2 food trucks not referencing burgers
      food_truck_fixture(%{
        description: "steaks and lobsters",
        food_truck_category: ctx.truck_category
      })

      food_truck_fixture(%{description: "seafood", food_truck_category: ctx.truck_category})

      assert {:ok, food_trucks} =
               FoodTrucks.search(
                 FoodTruckSearcher.FoodTrucks.SearchParams.new(%{
                   search_text: "burger"
                 })
               )

      for food_truck <- food_trucks do
        assert String.contains?(food_truck.description, "burger")
      end

      assert length(food_trucks) == num_burger_trucks
    end
  end
end
