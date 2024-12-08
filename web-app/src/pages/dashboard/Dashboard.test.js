import React from "react";
import { render, screen } from "@testing-library/react";
import { Provider } from "react-redux";
import { configureStore } from "@reduxjs/toolkit";
import dashboardReducer from "./state";
import Dashboard from "./Dashboard";

// Mock Redux store
const store = configureStore({
  reducer: {
    dashboard: dashboardReducer,
  },
});

describe("Dashboard Component", () => {
  test("renders Filter component", () => {
    render(
      <Provider store={store}>
        <Dashboard />
      </Provider>
    );

    expect(screen.getByText(/Filter/i)).toBeInTheDocument();
  });

  test("does not render Listings and Chat initially", () => {
    render(
      <Provider store={store}>
        <Dashboard />
      </Provider>
    );

    expect(screen.queryByText(/Listings/i)).not.toBeInTheDocument();
    expect(screen.queryByText(/Chat/i)).not.toBeInTheDocument();
  });

  test("displays LoadingMessage when loading state is true", () => {
    render(
      <Provider
        store={configureStore({
          reducer: { dashboard: dashboardReducer },
          preloadedState: {
            dashboard: {
              isLoading: true,
              filters: {},
              listings: [],
              chat: { messages: [], propertyContext: null },
            },
          },
        })}
      >
        <Dashboard />
      </Provider>
    );

    expect(screen.getByText(/Loading.../i)).toBeInTheDocument();
  });
});