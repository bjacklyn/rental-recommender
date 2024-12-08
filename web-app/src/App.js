import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate, useParams } from "react-router-dom";
import { Provider } from "react-redux";
import store from "./store";
import Dashboard from "./pages/dashboard/Dashboard"; // Central Dashboard component
import Property from "./pages/property/Property"; // Property details component
import { ThemeProvider } from "styled-components";
import GlobalStyles from "./styles/GlobalStyles"; // Global styles for the application
import { lightTheme } from "./styles/theme"; // Theme configuration

const App = () => {
  const handleSignOut = () => {
    console.log("User signed out");
  };

  return (
    <Provider store={store}>
      <ThemeProvider theme={lightTheme}>
        <GlobalStyles />
        <Router>
          <Routes>
            <Route path="/web-app/" element={<Dashboard/>} />
            <Route path="/web-app/listing/:propertyId" element={<PropertyWrapper />} />
            <Route path="*" element={<Navigate to="/web-app/" replace />} />
          </Routes>
        </Router>
      </ThemeProvider>
    </Provider>
  );
};

// Wrapper Component for Property to Pass Dynamic Route Params
const PropertyWrapper = () => {
  const { propertyId } = useParams(); // Extract propertyId from URL
  return <Property propertyId={propertyId} />;
};

export default App;
