defmodule FoodTruckSearcherWeb.FoodTruckControllerTest do
  use FoodTruckSearcherWeb.ConnCase
  import FoodTruckSearcher.Fixtures

  describe "POST /api/food_trucks" do
    setup do
      truck_category = food_truck_category_fixture(%{name: "Truck"})
      food_truck_category_fixture(%{name: "Push Cart"})
      for _i <- 1..3 do
        food_truck_fixture(%{approved: true, food_truck_category: truck_category})
      end
      {:ok, %{}}
    end

    test "succeeds", %{conn: conn} do
      conn = post(conn, "/api/food_trucks", %{
        includeApproved: true,
        includeNotApproved: true,
        includeTruckCategory: true,
        includePushCartCategory: true,
        searchText: "",
        zipcode: "",
      })

      assert json = json_response(conn, 200)
      assert is_list(json)
      assert length(json) > 0
      for food_truck_json <- json do
        assert food_truck_json["name"]
        assert food_truck_json["description"]
        assert is_boolean(food_truck_json["approved"])
        assert food_truck_json["zipcode"]
        assert food_truck_json["category"] == "Truck"
      end
    end
  end
end
