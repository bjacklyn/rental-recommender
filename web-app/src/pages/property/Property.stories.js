import React from "react";
import Property from "./Property";
import { ThemeProvider } from "styled-components";
import { lightTheme } from "../../styles/theme"; // Import the specific theme
import { Provider } from "react-redux";
import { configureStore } from "@reduxjs/toolkit";
import propertyReducer from "./state";

const mockStore = configureStore({
  reducer: {
    property: propertyReducer,
  },
});

export default {
  title: "Pages/Property",
  component: Property,
  decorators: [
    (Story) => (
      <Provider store={mockStore}>
        <ThemeProvider theme={lightTheme}>
          <GlobalStyles />
          {Story()}
        </ThemeProvider>
      </Provider>
    ),
  ],
};

const Template = (args) => <Property {...args} />;

export const Default = Template.bind({});
Default.args = {
  propertyId: "123",
};