import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";

const InputWrapper = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing.small};
  width: 100%;
`;

const Label = styled.label`
  font-size: ${({ theme }) => theme.typography.fontSizeBase};
  font-weight: ${({ theme }) => theme.typography.headingFontWeight};
  color: ${({ theme }) => theme.colors.primaryText};
`;

const InputField = styled.input`
  padding: ${({ theme }) => theme.spacing.small};
  font-size: ${({ theme }) => theme.typography.fontSizeBase};
  color: ${({ theme }) => theme.colors.primaryText};
  background-color: ${({ theme }) => theme.colors.primaryBackground};
  border: 1px solid
    ${({ hasError, theme }) => (hasError ? theme.colors.error : theme.colors.border)};
  border-radius: ${({ theme }) => theme.borderRadius};
  outline: none;
  transition: ${({ theme }) => theme.transitions.default};

  &:focus {
    border-color: ${({ theme }) => theme.colors.primaryButton};
    box-shadow: 0 0 0 3px ${({ theme }) => theme.colors.primaryButton}33; /* Adds a subtle focus ring */
  }

  &::placeholder {
    color: ${({ theme }) => theme.colors.secondaryText};
  }
`;

const ErrorText = styled.span`
  font-size: ${({ theme }) => theme.typography.fontSizeBase};
  color: ${({ theme }) => theme.colors.error};
`;

const Input = ({ label, type, value, onChange, error, placeholder }) => {
  return (
    <InputWrapper>
      {label && <Label>{label}</Label>}
      <InputField
        type={type}
        value={value}
        onChange={onChange}
        placeholder={placeholder}
        hasError={!!error}
        aria-invalid={!!error}
      />
      {error && <ErrorText>{error}</ErrorText>}
    </InputWrapper>
  );
};

Input.propTypes = {
  label: PropTypes.string,
  type: PropTypes.string,
  value: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  error: PropTypes.string,
  placeholder: PropTypes.string,
};

Input.defaultProps = {
  label: null,
  type: "text",
  error: null,
  placeholder: "",
};

export default Input;
