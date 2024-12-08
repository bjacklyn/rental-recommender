import React, { useState } from "react";
import PropTypes from "prop-types";
import { Slider as AntdSlider, Typography } from "antd";
import styled from "styled-components";

const { Text } = Typography;

const SliderWrapper = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing.small};
  width: 100%;
`;


const Slider = ({ label, value, min, max, step, onChange, marks, tooltipVisible }) => (
  <SliderWrapper>
    {label && (
      <Text strong style={{ marginBottom: "8px" }}>
        {label}
      </Text>
    )}
    <AntdSlider
      range
      min={min}
      max={max}
      step={step}
      value={value}
      onChange={onChange}
      marks={marks}
      tooltip={{
        placement: "top",
      }}
    />
  </SliderWrapper>
);

Slider.propTypes = {
  label: PropTypes.string,
  value: PropTypes.arrayOf(PropTypes.number).isRequired,
  min: PropTypes.number.isRequired,
  max: PropTypes.number.isRequired,
  step: PropTypes.number,
  onChange: PropTypes.func.isRequired,
  marks: PropTypes.object,
  tooltipVisible: PropTypes.bool,
};

Slider.defaultProps = {
  label: null,
  step: 1,
  marks: null
};

export default Slider;
