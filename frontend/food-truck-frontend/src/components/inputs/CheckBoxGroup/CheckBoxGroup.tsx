import CheckBox from "./CheckBox";

interface Props {
  checkBoxes: { name: string; checked: boolean }[];
  onToggled?: (name: string, checked: boolean) => void;
}

function CheckBoxGroup({ checkBoxes, onToggled }: Props) {
  const handleToggled = (name: string, checked: boolean) => {
    if (onToggled) onToggled(name, checked);
  };

  return (
    <div className="d-inline-block">
      {checkBoxes.map(({ name, checked }) => (
        <CheckBox
          key={name}
          name={name}
          checked={checked}
          onToggled={handleToggled}
        />
      ))}
    </div>
  );
}

export default CheckBoxGroup;
