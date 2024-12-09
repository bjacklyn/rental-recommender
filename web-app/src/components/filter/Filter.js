import React, { useState } from "react";
import PropTypes from "prop-types";
import Input from "../common/Input";
import Select from "../common/Select";
import Slider from "../common/Slider";
import Button from "../common/Button";
import { FilterWrapper, FilterItem, ButtonItem } from "./Filter.styles";

const propertyTypeOptions = [
  { value: "apartment", label: "Apartment" },
  { value: "house", label: "House" },
  { value: "condo", label: "Condo" },
];

const Filter = ({
  initialValues = { pincode: "", propertyType: "apartment", bedrooms: [1, 3], sqft: [0, 2500] },
  onFilter,
}) => {
  const [pincode, setPincode] = useState(initialValues.pincode);
  const [propertyType, setPropertyType] = useState(initialValues.propertyType);
  const [bedrooms, setBedrooms] = useState(initialValues.bedrooms);
  const [sqft, setSqft] = useState(initialValues.sqft);

  const handleFilter = () => {
    // Convert the filters into the API-required format
    const filters = {
      pincode,
      min_beds: bedrooms[0],
      max_beds: bedrooms[1],
      min_sqft: sqft[0],
      max_sqft: sqft[1],
      property_type: propertyType, // Optional, if needed
    };

    onFilter(filters); // Call the parent onFilter handler
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
        <Slider
          label="Bedrooms"
          value={bedrooms}
          min={0}
          max={5}
          step={1}
          onChange={setBedrooms}
          marks={{
            0: "0",
            1: "1",
            2: "2",
            3: "3",
            4: "4",
            5: "5",
          }}
          tooltipVisible={true}
        />
      </FilterItem>
      <FilterItem>
        <Slider
          label="Sqft Range"
          value={sqft}
          min={0}
          max={5000}
          step={100}
          onChange={setSqft}
          marks={{
            0: "0",
            2500: "2500",
            5000: "5000",
          }}
          tooltipVisible={true}
        />
      </FilterItem>
      <ButtonItem>
        <Button type="primary" size="large" onClick={handleFilter}>
          Apply Filters
        </Button>
      </ButtonItem>
    </FilterWrapper>
  );
};

Filter.propTypes = {
  initialValues: PropTypes.shape({
    pincode: PropTypes.string,
    propertyType: PropTypes.string,
    bedrooms: PropTypes.arrayOf(PropTypes.number),
    sqft: PropTypes.arrayOf(PropTypes.number),
  }),
  onFilter: PropTypes.func.isRequired,
};

export default Filter;
