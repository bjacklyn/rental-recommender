import React from "react";
import Filter from "./Filter";
import { ThemeProvider } from "styled-components";
import { lightTheme } from "../../styles/theme";
import GlobalStyles from "../../styles/GlobalStyles";

export default {
  title: "Components/Filter", 
  component: Filter,         
};

const Template = (args) => (
  <ThemeProvider theme={lightTheme}>
    <GlobalStyles />
    <Filter {...args} />
  </ThemeProvider>
);

export const Default = Template.bind({});
Default.args = {
  initialValues: {
    pincode: "94016",
    propertyType: "apartment",
    bedrooms: 2,
    bathrooms: 1,
  },
  onFilter: (filters) => console.log("Filters applied:", filters),
};