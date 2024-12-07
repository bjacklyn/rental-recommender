import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";
import { Button as AntdButton } from "antd";

const StyledButton = styled(AntdButton)`
  &.ant-btn {
    padding: ${({ size, theme }) => {
      switch (size) {
        case "small":
          return theme.spacing.small;
        case "large":
          return theme.spacing.large;
        default:
          return theme.spacing.medium;
      }
    }};
    border-radius: ${({ theme }) => theme.borderRadius};
    border: ${({ variant, theme }) =>
      variant === "outline" ? `1px solid ${theme.colors.primaryButton}` : "none"};
    background-color: ${({ variant, theme }) => {
      switch (variant) {
        case "primary":
          return theme.colors.primaryButton;
        case "secondary":
          return theme.colors.secondaryButton;
        case "outline":
          return "transparent";
        default:
          return theme.colors.primaryButton;
      }
    }};
    color: ${({ variant, theme }) => {
      switch (variant) {
        case "outline":
          return theme.colors.primaryButton;
        case "primary":
          return theme.colors.primaryTextOnButton; 
        case "secondary":
          return theme.colors.secondaryTextOnButton;
        default:
          return theme.colors.primaryTextOnButton;
      }
    }};
    cursor: pointer;
    transition: ${({ theme }) => theme.transitions.default};
    box-shadow: ${({ variant, theme }) =>
      variant !== "outline" ? theme.boxShadow.default : "none"};

    &:hover {
      box-shadow: ${({ theme }) => theme.boxShadow.hover};
      opacity: 0.9;
    }

    &:disabled {
      background-color: ${({ theme }) => theme.colors.disabled};
      color: ${({ theme }) => theme.colors.secondaryText};
      cursor: not-allowed;
      box-shadow: none;
    }
  }
`;

const Button = ({ children, variant, size, onClick, disabled, loading }) => {
  return (
    <StyledButton
      type={variant === "primary" ? "primary" : "default"}
      size={size}
      onClick={onClick}
      disabled={disabled || loading}
      loading={loading}
      variant={variant}
    >
      {children}
    </StyledButton>
  );
};

Button.propTypes = {
  children: PropTypes.node.isRequired,
  variant: PropTypes.oneOf(["primary", "secondary", "outline"]),
  size: PropTypes.oneOf(["small", "medium", "large"]),
  onClick: PropTypes.func,
  disabled: PropTypes.bool,
  loading: PropTypes.bool,
};

Button.defaultProps = {
  variant: "primary",
  size: "medium",
  onClick: () => {},
  disabled: false,
  loading: false,
};

export default Button;
