import styles from "./CheckBox.module.css";

interface Props {
  name: string;
  checked: boolean;
  onToggled?: (name: string) => void;
}

function CheckBox({ name, checked, onToggled }: Props) {
  const handleToggled = () => {
    if (onToggled) onToggled(name);
  };

  return (
    <div
      onClick={handleToggled}
      className={["form-check", "mx-2", styles.checkBox].join(" ")}
    >
      <input
        className="form-check-input"
        type="checkbox"
        readOnly
        checked={checked}
      />
      <label className="form-check-label">{name}</label>
    </div>
  );
}

export default CheckBox;
