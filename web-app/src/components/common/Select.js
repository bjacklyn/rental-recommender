import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";

const SelectWrapper = styled.div`
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

const SelectField = styled.select`
  padding: ${({ theme }) => theme.spacing.small};
  font-size: ${({ theme }) => theme.typography.fontSizeBase};
  color: ${({ theme }) => theme.colors.primaryText};
  background-color: ${({ theme }) => theme.colors.primaryBackground};
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: ${({ theme }) => theme.borderRadius};
  outline: none;
  transition: ${({ theme }) => theme.transitions.default};
  cursor: pointer;

  &:focus {
    border-color: ${({ theme }) => theme.colors.primaryButton};
    box-shadow: 0 0 0 3px ${({ theme }) => theme.colors.primaryButton}33;
  }

  &:hover {
    background-color: ${({ theme }) => theme.colors.secondaryBackground};
  }

  option {
    background-color: ${({ theme }) => theme.colors.primaryBackground};
    color: ${({ theme }) => theme.colors.primaryText};
  }
`;

const Select = ({ label, options, value, onChange }) => {
  return (
    <SelectWrapper>
      {label && <Label>{label}</Label>}
      <SelectField value={value} onChange={onChange}>
        {options.map((option) => (
          <option key={option.value} value={option.value}>
            {option.label}
          </option>
        ))}
      </SelectField>
    </SelectWrapper>
  );
};

Select.propTypes = {
  label: PropTypes.string,
  options: PropTypes.arrayOf(
    PropTypes.shape({
      value: PropTypes.string.isRequired,
      label: PropTypes.string.isRequired,
    })
  ).isRequired,
  value: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
};

Select.defaultProps = {
  label: null,
};

export default Select;
