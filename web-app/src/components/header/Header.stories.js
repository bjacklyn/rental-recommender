import React from "react";
import Header from "./Header";
import { ThemeProvider } from "styled-components";
import GlobalStyles from "../../styles/GlobalStyles";
import { lightTheme } from "../../styles/theme";

export default {
  title: "Components/Header",
  component: Header,
};

const Template = (args) => (
  <ThemeProvider theme={lightTheme}>
    <GlobalStyles />
    <Header {...args} />
  </ThemeProvider>
);

export const Default = Template.bind({});
Default.args = {
  onSignOut: () => alert("Signed Out"),
};