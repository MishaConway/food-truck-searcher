import styles from "./RecentSearches.module.css";

interface Props {
  searches: string[];
  selected: string;
  onRecentSearchSelected: (search: string) => void;
  onClear: () => void;
}

function RecentSearches({
  searches,
  selected,
  onRecentSearchSelected,
  onClear,
}: Props) {
  const renderSearch = (search: string, key: number, isSelected: boolean) => {
    return (
      <a
        href="#"
        key={key}
        onClick={() => {
          onRecentSearchSelected(search);
        }}
        className={[
          "mx-2",
          styles.search,
          isSelected ? styles.active : "",
        ].join(" ")}
      >
        {search}
      </a>
    );
  };

  if (searches.length === 0) return null;

  return (
    <div className={styles.searches}>
      {searches.map((search, i) =>
        renderSearch(search, i, selected === search)
      )}
      <a
        className={styles.clear}
        onClick={() => {
          onClear();
        }}
      >
        clear
      </a>
    </div>
  );
}

export default RecentSearches;
