import { configureStore } from "@reduxjs/toolkit";
import dashboardReducer from "./pages/dashboard/state";
import propertyReducer from "./pages/property/state";
import chatReducer from './components/chat/chatSlice'

const store = configureStore({
  reducer: {
    dashboard: dashboardReducer,
    property: propertyReducer,
    chat: chatReducer,
  },
  devTools: process.env.NODE_ENV !== "production", // Enable Redux DevTools in development
});

export default store;
