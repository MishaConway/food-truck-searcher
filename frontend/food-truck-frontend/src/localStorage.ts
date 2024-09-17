import { FoodTruckType } from "./types/foodTruck";
import { SavedSearch, SearchParams } from "./types/searches";


const localStorageKey = "savedSearches";  

export function getLocalStorageSavedSearches(): SavedSearch[] {
    return getItemInLocalStorage(localStorageKey) || [];
} 

export function addLocalStorageSavedSearch(searchParams: SearchParams, searchResults: FoodTruckType[]) {
    if( searchParams.searchName.length > 0 ) {
        let localStorageSavedSearches = getLocalStorageSavedSearches();
       
        // remove anything already saved under this name 
        localStorageSavedSearches = localStorageSavedSearches.filter(savedSearch => savedSearch.searchParams.searchName !== searchParams.searchName);
        
        // add new saved search
        localStorageSavedSearches = localStorageSavedSearches.concat({
            searchParams: searchParams, searchResults: searchResults
        })

        setItemInLocalStorage(localStorageKey, localStorageSavedSearches);
    }
}

export function clearLocalStorageSavedSearches() {
    setItemInLocalStorage(localStorageKey, []);
}

function getItemInLocalStorage(key: string) {
    const json = localStorage.getItem(key);

    if (json) {
      return JSON.parse(json);
    } else {
        return null;
    }   
}

function setItemInLocalStorage(key: string, item: any) {
    localStorage.setItem(key, JSON.stringify(item));
}



