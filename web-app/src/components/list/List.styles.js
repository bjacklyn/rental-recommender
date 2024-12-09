import styled from "styled-components";

export const ListWrapper = styled.div`
  max-height: 80vh; /* Adjust the height as needed */
  overflow-y: auto; /* Enable vertical scrolling */
`;

export const EmptyMessage = styled.div`
  text-align: center;
  margin-top: 20px;
`;

export const PaginationWrapper = styled.div`
  display: flex;
  justify-content: center;
  margin-top: 20px;
`;