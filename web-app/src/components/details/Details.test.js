import React from "react";
import { render, screen } from "@testing-library/react";
import Details from "./Details";

const mockProperty = {
  images: ["https://via.placeholder.com/800x400"],
  address: "100 E Santa Clara St, #314, San Jose, CA 95112",
  price: "$4,300/month",
  bedrooms: 3,
  bathrooms: 3,
  sqft: 1480,
  description: "A vibrant and luxurious property in the heart of San Jose.",
  additionalDetails: ["Property type: Apartment", "Year built: 2015", "Pets Friendly"],
};

const mockSimilarListings = [
  {
    id: "1",
    image: "https://via.placeholder.com/300",
    title: "100 El Camino Real",
    price: "$4,000",
    bedrooms: 2,
    bathrooms: 3,
    sqft: 1000,
  },
];

test("renders property details", () => {
  render(<Details property={mockProperty} similarListings={mockSimilarListings} />);

  expect(screen.getByText(/100 E Santa Clara St/i)).toBeInTheDocument();
  expect(screen.getByText(/$4,300\/month/i)).toBeInTheDocument();
});