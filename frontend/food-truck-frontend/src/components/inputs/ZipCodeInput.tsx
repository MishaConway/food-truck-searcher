import React from "react";

interface Props {
  zipCode: string;
  onChange: (zipCode: string) => void;
}

const ZipCodeInput = ({ zipCode, onChange }: Props) => {
  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = event.target;

    // Only allow numeric input and limit to 5 characters
    if (/^\d{0,5}$/.test(value)) {
      onChange(value);
    }
  };

  return (
    <input
      type="text"
      className="form-control mr-sm-2 mx-2"
      placeholder="Zipcode"
      value={zipCode}
      onChange={handleChange}
    />
  );
};

export default ZipCodeInput;
