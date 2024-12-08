import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";
import { Input as AntdInput, Form, Typography } from "antd";

const { Text } = Typography;

const StyledInput = styled(AntdInput)`
  &.ant-input {
    color: ${({ theme }) => theme.colors.primaryText};
    background-color: ${({ theme }) => theme.colors.primaryBackground};
    border: 1px solid
      ${({ theme, hasError }) => (hasError ? theme.colors.error : theme.colors.border)};
    border-radius: ${({ theme }) => theme.borderRadius};
    transition: ${({ theme }) => theme.transitions.default};

    &:focus {
      border-color: ${({ theme }) => theme.colors.primaryButton};
      box-shadow: 0 0 0 3px ${({ theme }) => theme.colors.primaryButton}33;
    }

    &::placeholder {
      color: ${({ theme }) => theme.colors.secondaryText};
    }
  }
`;

const StyledFormItem = styled(Form.Item)`
  &.ant-form-item {
    label {
      font-size: ${({ theme }) => theme.typography.fontSizeBase}; // Matches AntD default
      color: ${({ theme }) => theme.colors.primaryText}; // Matches your primary text color
      font-weight: ${({ theme }) => theme.typography.bodyFontWeight}; // Matches other AntD typography
    }

    .ant-form-item-explain-error {
      color: ${({ theme }) => theme.colors.error}; // Matches AntD error message color
      font-size: ${({ theme }) => theme.typography.fontSizeBase};
    }
  }
`;

const InputLabelWrapper = styled.div`
 display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing.small};
  width: 100%;
`

const Input = ({ label, type, value, onChange, error, placeholder }) => {
  return (
    <StyledFormItem
      validateStatus={error ? "error" : ""}
      help={error}
    >
      <InputLabelWrapper>
      {label && (
        <Text strong style={{ marginBottom: "6px" }}>
          {label}
        </Text>
      )}
      <StyledInput
        type={type}
        value={value}
        onChange={onChange}
        placeholder={placeholder}
        hasError={!!error}
        aria-invalid={!!error}
      />
      </InputLabelWrapper>
    </StyledFormItem>
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
