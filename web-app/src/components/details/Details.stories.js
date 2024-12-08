import React from "react";
import Details from "./Details";
import { ThemeProvider } from "styled-components";
import GlobalStyles from "../../styles/GlobalStyles";
import { lightTheme } from "../../styles/theme";

export default {
  title: "Components/Details",
  component: Details,
};

const Template = (args) => (
  <ThemeProvider theme={lightTheme}>
    <GlobalStyles />
    <Details {...args} />
  </ThemeProvider>
);

export const Default = Template.bind({});
Default.args = {
  property: {
    images: [
      "https://via.placeholder.com/800x400",
      "https://via.placeholder.com/800x400",
    ],
    address: "100 E Santa Clara St, #314, San Jose, CA 95112",
    price: "$4,300/month",
    bedrooms: 3,
    bathrooms: 3,
    sqft: 1480,
    description: "A vibrant and luxurious property in the heart of San Jose.",
    additionalDetails: [
      "Property type: Apartment",
      "Year built: 2015",
      "Pets Friendly",
    ],
  },
  similarListings: [
    {
      id: "1",
      image: "https://via.placeholder.com/300",
      title: "100 El Camino Real",
      price: "$4,000",
      bedrooms: 2,
      bathrooms: 3,
      sqft: 1000,
    },
    {
      id: "2",
      image: "https://via.placeholder.com/300",
      title: "200 El Camino Real",
      price: "$4,500",
      bedrooms: 3,
      bathrooms: 2,
      sqft: 1200,
    },
  ],
};