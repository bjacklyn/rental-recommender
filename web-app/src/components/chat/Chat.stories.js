import React from "react";
import Chat from "./Chat";
import { ThemeProvider } from "styled-components";
import GlobalStyles from "../../styles/GlobalStyles";
import { lightTheme } from "../../styles/theme";

export default {
  title: "Components/Chat",
  component: Chat,
};

const Template = (args) => (
  <ThemeProvider theme={lightTheme}>
    <GlobalStyles />
    <Chat {...args} />
  </ThemeProvider>
);

export const Default = Template.bind({});
Default.args = {
  initialMessages: [
    {
      id: 1,
      sender: "user",
      content: "Hi there!",
      timestamp: "10:00 AM",
    },
    {
      id: 2,
      sender: "bot",
      content: "Hello! How can I help you?",
      timestamp: "10:01 AM",
    },
  ],
};