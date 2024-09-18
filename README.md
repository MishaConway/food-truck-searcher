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
 to go back to your prior searches by just clicking on any of those recent searches. Since these recent searches are stored
 in local storage, you can even access them if you refresh the page. 

 To see an example of all this works in practice, I have provided a video to go along with this app. 


If I had more time to finetune this app, I would focus on the following:
- more code comments on both the elixir and react sides
- investigating opportunities to simplify the existing code even more. For instance, I suspect code in the 
  FoodTrucks elixir context could be much simplified. At the moment, much of of this was rushed and the focus
  was just to get tests passing that would satisfy the needed api functionality. 
- automated test coverage for the react sides. 
- more test coverage for the elixir food trucks controller
- removing much of the boilerplate cruft included from generating the elixir app. For instance, I don't need anything associated 
  with the PageController. 
- eager loading / preloading in the food trucks controller. There is currently an n+1 query due to the food_trucks -> food_truck_categories 
  association.

 In the current iteration, many of my tradeoffs came as part of a time boxing approach. I had a certain idea of a greenfield prototype
 app I wanted to build out and I prioritized rapid development over solidifying all of the points above. As such, more of my focus
 was on elixir test coverage and that would prove the functionality of the elixir api as I originally intended as long as I implemented elixir
 app logic that passed the tests to ensure it would be ready to use to service the react app within my time boxed approach. 

 The tradeoff then was having all of the code as simplified and as performant as I would prefer due to this rapidly prototyped TDD approach. 