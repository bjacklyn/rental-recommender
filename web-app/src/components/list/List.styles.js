import styled from "styled-components";

export const ListWrapper = styled.div`
  flex: 2;
  padding: 16px;

  .ant-row {
    margin: 0; /* Reset Row margins for consistent spacing */
  }
`;

export const EmptyMessage = styled.p`
  text-align: center;
  color: ${({ theme }) => theme.colors.text};
  font-size: 16px;
  margin-top: 20px;
`;