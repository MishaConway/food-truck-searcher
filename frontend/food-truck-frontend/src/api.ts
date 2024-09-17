import axios from "axios";
import { SearchParams } from "./components/SearchForm/SearchForm";
import { FoodTruckType } from "./types/foodTruck";

export async function searchFoodTrucks(searchParams: SearchParams) {
    const response = await axios.post<FoodTruckType[]>(
        "http://localhost:4000/api/food_trucks",
        searchParams
      );
   return response.data;   
}