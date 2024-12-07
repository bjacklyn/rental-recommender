import styled from "styled-components";

export const PropertyWrapper = styled.div`
  padding: 20px;
  background-color: ${({ theme }) => theme.colors.background};
  max-width: 1200px;
  margin: auto;

  @media (max-width: 768px) {
    padding: 10px;
  }
`;