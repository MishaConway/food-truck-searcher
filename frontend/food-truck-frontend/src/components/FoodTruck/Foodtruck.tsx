import { FoodTruckType } from "../../types/foodTruck";

interface Props {
  foodTruck: FoodTruckType;
  rank: number;
}

function FoodTruck({ foodTruck, rank }: Props) {
  return (
    <tr>
      <th scope="row">{rank}</th>
      <td>{foodTruck.name}</td>
      <td>{foodTruck.approved ? "YES" : "NO"}</td>
      <td>{foodTruck.category}</td>
      <td>{foodTruck.zipcode}</td>
      <td className="px-4">{foodTruck.description}</td>
    </tr>
  );
}

export default FoodTruck;
