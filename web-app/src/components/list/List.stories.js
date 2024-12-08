import React from "react";
import List from "./List";
import { ThemeProvider } from "styled-components";
import GlobalStyles from "../../styles/GlobalStyles";
import { lightTheme } from "../../styles/theme";

// Default export required by Storybook
export default {
  title: "Components/List", // Storybook category and component name
  component: List,
};

// Template to wrap the List component with global styles and theme
const Template = (args) => (
  <ThemeProvider theme={lightTheme}>
    <GlobalStyles />
    <List {...args} />
  </ThemeProvider>
);

// Default story with example data
export const Default = Template.bind({});
Default.args = {
  items: [
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
    {
      id: "3",
      image: "https://via.placeholder.com/300",
      title: "Cozy Studio",
      price: "$800/month",
      bedrooms: 1,
      bathrooms: 1,
    },
  ],
  onItemClick: (id) => alert(`Clicked property ID: ${id}`),
};