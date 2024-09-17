import React from "react";

interface Props {
  text: string;
  placeholder: string;
  onChange: (text: string) => void;
}

const TextInput = ({ text, placeholder, onChange }: Props) => {
  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { value } = event.target;
    onChange(value);
  };

  return (
    <input
      type="text"
      className="form-control mr-sm-2 mx-2"
      placeholder={placeholder}
      value={text}
      onChange={handleChange}
    />
  );
};

export default TextInput;
