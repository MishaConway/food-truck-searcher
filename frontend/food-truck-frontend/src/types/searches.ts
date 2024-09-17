import { FoodTruckType } from "./foodTruck";

export interface SavedSearch {
    searchParams: SearchParams;
    searchResults: FoodTruckType[];       
  }  

  export interface SearchParams {
    searchName: string;
    searchText: string;
    includeApproved: boolean;
    includeNotApproved: boolean;
    includeTruckCategory: boolean;
    includePushCartCategory: boolean;
    zipcode: string;
  }

  export function defaultSearchParams(): SearchParams {
    return {
      searchName: "",
      includeApproved: true,
      includeNotApproved: true,
      includeTruckCategory: true,
      includePushCartCategory: true,
      searchText: "",
      zipcode: "",
    };
  }