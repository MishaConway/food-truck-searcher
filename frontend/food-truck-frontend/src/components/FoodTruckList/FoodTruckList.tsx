import FoodTruckType from "../../types/foodTruck";
import FoodTruck from "../FoodTruck/Foodtruck";

interface Props {
  foodTrucks: FoodTruckType[];
}

function FoodTruckList({ foodTrucks }: Props) {
  return (
    <table className="mx-4 px-4 table">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col">Name</th>
          <th scope="col">Approved</th>
          <th scope="col">Category</th>
          <th scope="col">Zipcode</th>
          <th scope="col">Description</th>
        </tr>
      </thead>
      <tbody>
        {foodTrucks.map((foodTruck, i) => (
          <FoodTruck key={i} rank={i + 1} foodTruck={foodTruck}></FoodTruck>
        ))}
      </tbody>
    </table>
  );
}

export default FoodTruckList;
