import React from "react";
import { Provider } from "react-redux";
import { configureStore } from "@reduxjs/toolkit";
import { ThemeProvider } from "styled-components";
import dashboardReducer from "./state";
import Dashboard from "./Dashboard";
import { lightTheme } from "../../styles/theme"; // Adjust the path as needed

const store = configureStore({
  reducer: {
    dashboard: dashboardReducer,
  },
});

export default {
  title: "Pages/Dashboard",
  component: Dashboard,
  decorators: [
    (Story) => (
      <Provider store={store}>
        <ThemeProvider theme={lightTheme}>
          {Story()}
        </ThemeProvider>
      </Provider>
    ),
  ],
};

const Template = (args) => <Dashboard {...args} />;

export const Default = Template.bind({});
Default.args = {};