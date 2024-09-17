import CheckBoxGroup from "../inputs/CheckBoxGroup/CheckBoxGroup";
import ZipCodeInput from "../inputs/ZipCodeInput";
import TextInput from "../inputs/TextInput";
import { BsFillSearchHeartFill } from "react-icons/bs";
import { SearchParams } from "../../types/searches";

interface Props {
  isSearching: boolean;
  searchParams: SearchParams;
  onParamsChange: (params: SearchParams) => void;
  onNewSearch: () => void;
}

function SearchForm({
  isSearching,
  searchParams,
  onParamsChange,
  onNewSearch,
}: Props) {
  const truckCheckBoxName = "Truck";
  const pushCartCheckBoxName = "Push Cart";
  const approvedCheckBoxName = "Approved";
  const notApprovedCheckBoxName = "Not Approved";

  const handleNewSearch = (event: React.SyntheticEvent<HTMLFormElement>) => {
    console.log("went to handleNewSearch");

    event.preventDefault();

    onNewSearch();
  };

  const handleCheckBoxGroupToggled = (name: string) => {
    switch (name) {
      case truckCheckBoxName:
        onParamsChange({
          ...searchParams,
          includeTruckCategory: !searchParams.includeTruckCategory,
        });
        break;
      case pushCartCheckBoxName:
        onParamsChange({
          ...searchParams,
          includePushCartCategory: !searchParams.includePushCartCategory,
        });
        break;
      case approvedCheckBoxName:
        onParamsChange({
          ...searchParams,
          includeApproved: !searchParams.includeApproved,
        });
        break;
      case notApprovedCheckBoxName:
        onParamsChange({
          ...searchParams,
          includeNotApproved: !searchParams.includeNotApproved,
        });
        break;
    }
  };

  const handleSearchNameChange = (searchName: string) => {
    onParamsChange({ ...searchParams, searchName: searchName.trim() });
  };

  const handleSearchTextChange = (searchText: string) => {
    onParamsChange({ ...searchParams, searchText: searchText.trim() });
  };

  const handleZipCodeChange = (zipCode: string) => {
    onParamsChange({ ...searchParams, zipcode: zipCode });
  };

  const searchButtonIcons = () => {
    if (isSearching) {
      return (
        <div className="spinner-border" role="status">
          <span className="sr-only"></span>
        </div>
      );
    } else {
      return <BsFillSearchHeartFill size={32} />;
    }
  };

  return (
    <>
      <form className="d-flex align-items-center flex-nowrap">
        <TextInput
          placeholder="Name this Search"
          onChange={handleSearchNameChange}
          text={searchParams.searchName}
        />
        <TextInput
          placeholder="Search Keywords"
          onChange={handleSearchTextChange}
          text={searchParams.searchText}
        />
        <ZipCodeInput
          onChange={handleZipCodeChange}
          zipCode={searchParams.zipcode}
        />

        <CheckBoxGroup
          checkBoxes={[
            {
              name: truckCheckBoxName,
              checked: searchParams.includeTruckCategory,
            },
            {
              name: pushCartCheckBoxName,
              checked: searchParams.includePushCartCategory,
            },
          ]}
          onToggled={handleCheckBoxGroupToggled}
        />
        <CheckBoxGroup
          checkBoxes={[
            {
              name: approvedCheckBoxName,
              checked: searchParams.includeApproved,
            },
            {
              name: notApprovedCheckBoxName,
              checked: searchParams.includeNotApproved,
            },
          ]}
          onToggled={handleCheckBoxGroupToggled}
        />

        <button
          className="btn btn-outline-success my-2 my-sm-0 mx-4"
          onClick={handleNewSearch}
        >
          Search
          {searchButtonIcons()}
        </button>
      </form>
    </>
  );
}

export default SearchForm;
