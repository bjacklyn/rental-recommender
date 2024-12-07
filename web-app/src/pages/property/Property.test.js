import React from "react";
import { render, screen } from "@testing-library/react";
import { Provider } from "react-redux";
import { configureStore } from "@reduxjs/toolkit";
import propertyReducer from "./state";
import Property from "./Property";

const mockStore = configureStore({
  reducer: {
    property: propertyReducer,
  },
});

describe("Property Component", () => {
  test("renders Property without crashing", () => {
    render(
      <Provider store={mockStore}>
        <Property propertyId="123" />
      </Provider>
    );
    expect(screen.getByText(/Loading.../i)).toBeInTheDocument();
  });

  test("renders error message on fetch failure", () => {
    render(
      <Provider
        store={configureStore({
          reducer: { property: propertyReducer },
          preloadedState: {
            property: {
              property: null,
              similarListings: [],
              isLoading: false,
              error: "Failed to fetch data",
            },
          },
        })}
      >
        <Property propertyId="123" />
      </Provider>
    );
    expect(screen.getByText(/Failed to fetch data/i)).toBeInTheDocument();
  });
});