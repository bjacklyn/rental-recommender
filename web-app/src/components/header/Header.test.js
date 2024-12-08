import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import Header from "./Header";

test("renders header with sign out button", () => {
  render(<Header onSignOut={() => {}} />);

  expect(screen.getByText(/My Rental App/i)).toBeInTheDocument();
  expect(screen.getByText(/Sign Out/i)).toBeInTheDocument();
});

test("calls onSignOut when sign out button is clicked", () => {
  const mockSignOut = jest.fn();
  render(<Header onSignOut={mockSignOut} />);

  fireEvent.click(screen.getByText(/Sign Out/i));
  expect(mockSignOut).toHaveBeenCalledTimes(1);
});