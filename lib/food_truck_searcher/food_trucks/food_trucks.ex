defmodule FoodTruckSearcher.FoodTrucks do
  alias FoodTruckSearcher.FoodTrucks.FoodTruck
  import Ecto.Query

  @spec create(map()) :: {:ok, FoodTruck.t()} | {:error, Ecto.Changeset.t()}
  def create(attrs) do
    %FoodTruck{}
    |> FoodTruck.changeset(attrs)
    |> FoodTruckSearcher.Repo.insert()
  end

  @spec find_by_name(String.t()) :: {:ok, FoodTruck.t()} | {:error, :not_found}
  def find_by_name(name) when is_binary(name) do
    FoodTruck
    |> where([food_truck], food_truck.name == ^name)
    |> FoodTruckSearcher.Repo.one()
    |> case do
      %FoodTruck{} = food_truck -> {:ok, food_truck}
      nil -> {:error, :not_found}
    end
  end

  @spec search(FoodTruckSearcher.FoodTrucks.SearchParams.t()) ::
          {:ok, [FoodTruck.t()]} | {:error, String.t()}
  def search(%FoodTruckSearcher.FoodTrucks.SearchParams{} = params) do
    from(food_truck in FoodTruck, as: :food_truck)
    |> filter_search_by_approved(params)
    |> filter_search_by_zipcode(params)
    |> filter_search_by_search_text(params)
    |> filter_search_by_category(params)
    |> case do
      {:error, _} = error ->
        error

      query ->
        food_trucks =
          query
          #|> FoodTruckSearcher.Repo.preload([:food_truck_category])
          |> FoodTruckSearcher.Repo.all()
        {:ok, food_trucks}
    end
  end

  defp filter_search_by_zipcode(query, %{zipcode: zipcode}) do
    if String.length(to_string(zipcode)) > 0,
      do: where(query, [food_truck], food_truck.zipcode == ^zipcode),
      else: query
  end

  def filter_search_by_search_text(query, %{search_text: search_text}) do
    search = "%#{search_text}%"

    if String.length(to_string(search_text)) > 0,
      do: where(query, [food_truck], ilike(food_truck.description, ^search)),
      else: query
  end

  defp filter_search_by_approved(query, params) do
    cond do
      params.include_approved and params.include_not_approved ->
        query

      params.include_approved ->
        where(query, [food_truck], food_truck.approved == true)

      params.include_not_approved ->
        where(query, [food_truck], food_truck.approved == false)
    end
  end

  defp filter_search_by_category(query, params) do
    with {:ok, truck_category} <- FoodTruckSearcher.FoodTruckCategories.find_by_name("Truck"),
         {:ok, push_cart_category} <-
           FoodTruckSearcher.FoodTruckCategories.find_by_name("Push Cart") do
      truck_category_id = truck_category.id
      push_cart_category_id = push_cart_category.id

      cond do
        params.include_truck_category and params.include_push_cart_category ->
          query

        params.include_truck_category ->
          where(query, [food_truck], food_truck.food_truck_category_id == ^truck_category_id)

        params.include_push_cart_category ->
          where(query, [food_truck], food_truck.food_truck_category_id == ^push_cart_category_id)

        true ->
          where(query, 1 == 0)
      end
    end
  end
end
