defmodule FoodTruckSearcher.Repo do
  use Ecto.Repo,
    otp_app: :food_truck_searcher,
    adapter: Ecto.Adapters.Postgres
end
