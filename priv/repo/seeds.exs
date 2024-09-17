# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodTruckSearcher.Repo.insert!(%FoodTruckSearcher.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, csv_string} = File.read("#{File.cwd!()}/priv/Mobile_Food_Facility_Permit.csv")

food_truck_rows =
  for row <- NimbleCSV.RFC4180.parse_string(csv_string) do
    [
      _,
      name,
      category,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      description,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      approved_at,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      zipcode,
      _
    ] =
      row

    IO.puts("approved_at is #{approved_at}")

    %{
      name: name,
      category: category,
      approved_at: approved_at,
      description: description,
      zipcode: zipcode
    }
  end

food_truck_category_names =
  food_truck_rows
  |> Enum.map(& &1.category)
  |> Enum.uniq()

food_truck_categories =
  for name <- food_truck_category_names, into: Map.new() do
    name = if String.trim(name) == "", do: "Unknown", else: name

    case FoodTruckSearcher.FoodTruckCategories.find_by_name(name) do
      {:ok, category} ->
        {name, category}

      {:error, :not_found} ->
        {:ok, category} = FoodTruckSearcher.FoodTruckCategories.create(%{name: name})
        {name, category}
    end
  end

IO.puts("food_truck_categories is #{inspect(food_truck_categories)}")

for row <- food_truck_rows do
  case FoodTruckSearcher.FoodTrucks.find_by_name(row.name) do
    {:ok, truck} ->
      IO.puts("already foudn truck #{inspect(truck)}")
      :ok

    {:error, :not_found} ->
      category_name = if String.trim(row.category) == "", do: "Unknown", else: row.category
      approved = not (is_nil(row.approved_at) || String.trim(row.approved_at) == "")

      {:ok, food_truck} =
        FoodTruckSearcher.FoodTrucks.create(%{
          name: row.name,
          approved: approved,
          description: row.description,
          zipcode: row.zipcode,
          food_truck_category_id: food_truck_categories[category_name].id
        })
  end
end
