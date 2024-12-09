import { configureStore } from "@reduxjs/toolkit";
import dashboardReducer from "./pages/dashboard/state";
import propertyReducer from "./pages/property/state";

const store = configureStore({
  reducer: {
    dashboard: dashboardReducer,
    property: propertyReducer
  },
  devTools: process.env.NODE_ENV !== "production", // Enable Redux DevTools in development
});

export default store;
