import React from "react";
import { render } from "@testing-library/react";
import Filter from "./Filter";

test("renders Filter component without crashing", () => {
  const mockProps = {
    pincode: { value: "94016", onChange: jest.fn() },
    propertyType: { value: "apartment", onChange: jest.fn() },
    bedrooms: { value: 2, onChange: jest.fn() },
    bathrooms: { value: 1, onChange: jest.fn() },
    onSearch: jest.fn(),
  };

  const { getByText } = render(<Filter {...mockProps} />);
  expect(getByText("Search")).toBeInTheDocument();
});