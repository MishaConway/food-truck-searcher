defmodule FoodTruckSearcherWeb.FoodTruckController do
  use FoodTruckSearcherWeb, :controller
  alias FoodTruckSearcher.FoodTrucks.SearchParams

  def search(conn, params) do
    with normalized_params <- normalize_params(params),
         %{valid?: true} = changeset <-
           SearchParams.changeset(%SearchParams{}, normalized_params),
         %SearchParams{} = search_params <- Ecto.Changeset.apply_changes(changeset),
         {:ok, food_trucks} <- FoodTruckSearcher.FoodTrucks.search(search_params) do
      render(conn, "index.json", food_trucks: food_trucks)
    end
    # todo: add error fallback handler
  end

  defp normalize_params(params) do
    Recase.Enumerable.convert_keys(
      params,
      &Recase.to_snake/1
    )
  end
end
