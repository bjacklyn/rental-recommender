import styled from "styled-components";

export const FilterWrapper = styled.div`
  display: grid;
  grid-template-columns: repeat(4, 1fr) auto; /* Four equal columns + one for the button */
  align-items: center; /* Vertically align all items */
  gap: ${({ theme }) => theme.spacing.large}; /* Uniform spacing between items */
  padding: ${({ theme }) => theme.spacing.large}; /* Add padding inside the wrapper */
  width: 100%;
  max-width: 1200px;
  margin: 0 auto; /* Center the wrapper horizontally */
`;

export const FilterItem = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing.small}; /* Spacing between label and input */

  label {
    font-size: ${({ theme }) => theme.typography.fontSizeBase};
    font-weight: ${({ theme }) => theme.typography.bodyFontWeight};
    color: ${({ theme }) => theme.colors.primaryText};
  }

  input,
  select,
  .ant-slider {
    width: 100%; /* Ensure inputs and sliders stretch to container */
  }
`;

export const ButtonItem = styled.div`
  grid-column: 5; /* Place the button in the rightmost column */
  justify-self: end; /* Align the button to the right */
  padding-left: ${({ theme }) => theme.spacing.large}; /* Add space between the button and the rest */
`;
