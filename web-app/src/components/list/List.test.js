import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import List from "./List";

const mockItems = [
  {
    id: "1",
    image: "https://via.placeholder.com/300",
    title: "Spacious Apartment",
    price: "$1,200/month",
    bedrooms: 2,
    bathrooms: 1,
  },
  {
    id: "2",
    image: "https://via.placeholder.com/300",
    title: "Luxury Condo",
    price: "$2,500/month",
    bedrooms: 3,
    bathrooms: 2,
  },
];

test("renders list with items", () => {
  render(<List items={mockItems} onItemClick={() => {}} />);

  expect(screen.getByText(/Spacious Apartment/i)).toBeInTheDocument();
  expect(screen.getByText(/Luxury Condo/i)).toBeInTheDocument();
});

test("calls onItemClick when a card is clicked", () => {
  const mockClickHandler = jest.fn();
  render(<List items={mockItems} onItemClick={mockClickHandler} />);

  const card = screen.getByText(/Spacious Apartment/i);
  fireEvent.click(card);

  expect(mockClickHandler).toHaveBeenCalledWith("1");
});