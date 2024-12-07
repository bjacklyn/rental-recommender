import React, { useState } from "react";
import PropTypes from "prop-types";
import Input from "../common/Input";
import Select from "../common/Select";
import Slider from "../common/Slider";
import Button from "../common/Button";
import { FilterWrapper, FilterItem } from "./Filter.styles";

const propertyTypeOptions = [
  { value: "apartment", label: "Apartment" },
  { value: "house", label: "House" },
  { value: "condo", label: "Condo" },
];

const Filter = ({
  initialValues = { pincode: "", propertyType: "apartment", bedrooms: 0, sqft: [500, 5000] },
  onFilter = () => {},
}) => {
  const [pincode, setPincode] = useState(initialValues.pincode);
  const [propertyType, setPropertyType] = useState(initialValues.propertyType);
  const [bedrooms, setBedrooms] = useState(initialValues.bedrooms);
  const [sqft, setSqft] = useState(initialValues.sqft);

  const handleFilter = () => {
    onFilter({ pincode, propertyType, bedrooms, sqft });
  };

  return (
    <FilterWrapper>
      <FilterItem>
        <Input
          label="Pincode"
          type="text"
          value={pincode}
          onChange={(e) => setPincode(e.target.value)}
          placeholder="Enter pincode"
        />
      </FilterItem>
      <FilterItem>
        <Select
          label="Property Type"
          value={propertyType}
          onChange={(e) => setPropertyType(e.target.value)}
          options={propertyTypeOptions}
        />
      </FilterItem>
      <FilterItem>
        <Slider
          label="Bedrooms"
          value={bedrooms}
          min={0}
          max={5}
          step={1}
          onChange={setBedrooms}
        />
      </FilterItem>
      <FilterItem>
        <Slider
          label="Sqft Range"
          value={sqft}
          min={0}
          max={5000}
          step={100}
          onChange={(value) => setSqft(value)}
        />
      </FilterItem>
      <FilterItem>
        <Button variant="primary" size="large" onClick={handleFilter}>
          Apply Filters
        </Button>
      </FilterItem>
    </FilterWrapper>
  );
};

Filter.propTypes = {
  initialValues: PropTypes.shape({
    pincode: PropTypes.string,
    propertyType: PropTypes.string,
    bedrooms: PropTypes.number,
    sqft: PropTypes.arrayOf(PropTypes.number),
  }),
  onFilter: PropTypes.func,
};

export default Filter;
