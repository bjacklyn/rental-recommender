import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";

const SliderWrapper = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing.small};
  width: 100%;
`;

const LabelRow = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

const Label = styled.label`
  font-size: ${({ theme }) => theme.typography.fontSizeBase};
  font-weight: ${({ theme }) => theme.typography.headingFontWeight};
  color: ${({ theme }) => theme.colors.primaryText};
`;

const Value = styled.span`
  font-size: ${({ theme }) => theme.typography.fontSizeBase};
  font-weight: ${({ theme }) => theme.typography.bodyFontWeight};
  color: ${({ theme }) => theme.colors.secondaryText};
`;

const Input = styled.input`
  width: 100%;
  cursor: pointer;
  appearance: none;
  height: 6px;
  background: ${({ theme }) => theme.colors.border};
  border-radius: ${({ theme }) => theme.borderRadius};
  transition: background-color ${({ theme }) => theme.transitions.default};

  &::-webkit-slider-thumb {
    appearance: none;
    width: 16px;
    height: 16px;
    background: ${({ theme }) => theme.colors.primaryButton};
    border: 2px solid ${({ theme }) => theme.colors.primaryBackground};
    border-radius: 50%;
    cursor: pointer;
    transition: background-color ${({ theme }) => theme.transitions.default};
  }

  &::-moz-range-thumb {
    width: 16px;
    height: 16px;
    background: ${({ theme }) => theme.colors.primaryButton};
    border: 2px solid ${({ theme }) => theme.colors.primaryBackground};
    border-radius: 50%;
    cursor: pointer;
    transition: background-color ${({ theme }) => theme.transitions.default};
  }

  &:hover::-webkit-slider-thumb,
  &:hover::-moz-range-thumb {
    background: ${({ theme }) => theme.colors.secondaryButton};
  }

  &:focus {
    outline: 2px solid ${({ theme }) => theme.colors.primaryButton};
    outline-offset: 2px;
  }
`;

const Slider = ({ label, value, min, max, step, onChange }) => (
  <SliderWrapper>
    <LabelRow>
      {label && <Label>{label}</Label>}
      <Value>{value}</Value>
    </LabelRow>
    <Input
      type="range"
      min={min}
      max={max}
      step={step}
      value={value}
      onChange={(e) => onChange(Number(e.target.value))}
      aria-label={label || "slider"}
    />
  </SliderWrapper>
);

Slider.propTypes = {
  label: PropTypes.string,
  value: PropTypes.number.isRequired,
  min: PropTypes.number.isRequired,
  max: PropTypes.number.isRequired,
  step: PropTypes.number,
  onChange: PropTypes.func.isRequired,
};

Slider.defaultProps = {
  label: null,
  step: 1,
};

export default Slider;
