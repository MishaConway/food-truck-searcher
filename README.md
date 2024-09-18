# FoodTruckSearcher

To start your Phoenix server:

  * mix deps.get
  * mix ecto.migrate
  * mix run priv/repo/seeds.exs
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * This will start an elixir backend api at localhost:4000

To start react frontend
  * cd to food_truck_searcher/frontend/food-truck-frontend
  * npm install
  * npm run dev
  This will start a vite frontend server at localhost:5173 that will talk to the elixir backend at localhost:4000  


I am naming this app with the creative name of Food Truck Searcher. It provides a simple ui/ux for searching food trucks by the following:
 - keywords you'd like to search for in the description, for instance burgers or pizza
 - zipcode
 - whether food truck is a truck or a push cart
 - whether food truck has been approved or not

 Furthermore, if you name your search, then it will be stored in a 'recent searches' bar below the top nav. You will be able
 to go back to your prior searches by just clicking on any of those recent searches.

 To see an example of all this works in practice, I have provided a video to go along with this app. 



