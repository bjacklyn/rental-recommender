import React from "react";
import PropTypes from "prop-types";
import { HeaderContainer, Logo, SignOutButton } from "./Header.styles";

const Header = ({ onSignOut }) => {
  return (
    <HeaderContainer>
      <Logo>Rental Recommender </Logo>
    </HeaderContainer>
  );
};

Header.propTypes = {
  onSignOut: PropTypes.func.isRequired, 
};

export default Header;