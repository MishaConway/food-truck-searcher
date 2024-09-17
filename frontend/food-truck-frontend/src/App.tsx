import { useEffect, useState } from "react";
import "./App.css";
import NavBar from "./components/NavBar";
import RecentSearches from "./components/RecentSearches";
import FoodTruckList from "./components/FoodTruckList/FoodTruckList";
import SearchForm from "./components/SearchForm/SearchForm";
import { FoodTruckType } from "./types/foodTruck";
import { searchFoodTrucks } from "./api";
import {
  addLocalStorageSavedSearch,
  clearLocalStorageSavedSearches,
  getLocalStorageSavedSearches,
} from "./localStorage";
import {
  defaultSearchParams,
  SavedSearch,
  SearchParams,
} from "./types/searches";

function App() {
  const recentSearchNames = "recentSearchNames";

  const [searchParams, setSearchParams] = useState(defaultSearchParams());
  const [foodTrucks, setFoodTrucks] = useState<FoodTruckType[]>([]);
  const [isSearching, setIsSearching] = useState(true);
  const [recentSearches, setRecentSearches] = useState<SavedSearch[]>(
    getLocalStorageSavedSearches()
  );

  const handleSearchParamsChange = (searchParams: SearchParams) => {
    setSearchParams(searchParams);
  };

  const handleNewSearch = () => {
    setIsSearching(true);

    (async function () {
      const fetchedFoodTrucks = await searchFoodTrucks(searchParams);
      setFoodTrucks(fetchedFoodTrucks);
      setIsSearching(false);
      addLocalStorageSavedSearch(searchParams, fetchedFoodTrucks);
      setSearchParams({ ...searchParams, searchName: "" });
      setRecentSearches(getLocalStorageSavedSearches());
    })();
  };

  const handleRecentSearchSelected = (searchName: string) => {
    const newSearch = recentSearches.find(
      (search) => search.searchParams.searchName === searchName
    );
    if (newSearch) {
      setSearchParams({ ...newSearch.searchParams });
      setFoodTrucks(newSearch.searchResults);
    }
  };

  useEffect(() => {
    (async function () {
      const fetchedFoodTrucks = await searchFoodTrucks(searchParams);
      setFoodTrucks(fetchedFoodTrucks);
      setIsSearching(false);
    })();
  }, []);

  const handleRecentSearchesCleared = () => {
    clearLocalStorageSavedSearches();
    setRecentSearches([]);
  }

  return (
    <>
      <NavBar>
        <SearchForm
          searchParams={searchParams}
          isSearching={isSearching}
          onParamsChange={handleSearchParamsChange}
          onNewSearch={handleNewSearch}
        />
      </NavBar>
      <RecentSearches
        searches={recentSearches.map(
          (search) => search.searchParams.searchName
        )}
        selected={searchParams.searchName}
        onRecentSearchSelected={handleRecentSearchSelected}
        onClear={handleRecentSearchesCleared}
      />
      <FoodTruckList foodTrucks={foodTrucks} />
    </>
  );
}

export default App;
