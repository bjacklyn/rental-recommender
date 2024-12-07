import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { Provider } from "react-redux";
import store from "./store"
import Dashboard from "./pages/dashboard/Dashboard"; // Central Dashboard component
import { ThemeProvider } from "styled-components";
import GlobalStyles from "./styles/GlobalStyles"; // Global styles for the application
import { lightTheme } from "./styles/theme"; // Theme configuration

const App = () => {
  const handleSignOut = () => {
    console.log("User signed out");
    // Add real sign-out/authentication logic here
  };

  return (
    <Provider store={store}>
      <ThemeProvider theme={lightTheme}>
        <GlobalStyles />
        <Router>
          <Routes>
            <Route path="/" element={<Dashboard onSignOut={handleSignOut} />} />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </Router>
      </ThemeProvider>
    </Provider>
  );
};

export default App;