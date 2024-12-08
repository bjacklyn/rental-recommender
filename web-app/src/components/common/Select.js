import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";
import { Dropdown, Menu, Button, Typography } from "antd";
import { DownOutlined } from "@ant-design/icons";

const { Text } = Typography;

const SelectWrapper = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  margin-bottom : 14px
`;


const StyledButton = styled(Button)`
  width: 100%;
  text-align: left;
  background-color: ${({ theme }) => theme.colors.primaryBackground};
  border: 1px solid ${({ theme }) => theme.colors.border};
  color: ${({ theme }) => theme.colors.primaryText};

  &:hover {
    background-color: ${({ theme }) => theme.colors.secondaryBackground};
    border-color: ${({ theme }) => theme.colors.primaryButton};
  }
`;

const Select = ({ label, options, value, onChange }) => {
  const handleMenuClick = ({ key }) => {
    onChange(key); // Call the onChange handler with the selected key
  };

  const menu = (
    <Menu onClick={handleMenuClick}>
      {options.map((option) => (
        <Menu.Item key={option.value}>{option.label}</Menu.Item>
      ))}
    </Menu>
  );

  const selectedOption = options.find((option) => option.value === value);

  return (
    <SelectWrapper>
      {label && (
        <Text strong style={{ marginBottom: "16px" }}>
          {label}
        </Text>
      )}
      <Dropdown overlay={menu} trigger={['click']} placement="bottomLeft">
        <StyledButton>
          {selectedOption ? selectedOption.label : "Select an option"} <DownOutlined />
        </StyledButton>
      </Dropdown>
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
