import styled from "styled-components";

export const FilterWrapper = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: ${({ theme }) => theme.spacing.medium};
  padding: ${({ theme }) => theme.spacing.medium};
  background-color: ${({ theme }) => theme.colors.secondaryBackground};
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: ${({ theme }) => theme.borderRadius};
  box-shadow: ${({ theme }) => theme.boxShadow.default};
`;

export const FilterItem = styled.div`
  flex: 1;
  min-width: 200px;

  @media (max-width: 768px) {
    min-width: 100%;
  }

  label {
    font-size: ${({ theme }) => theme.typography.fontSizeBase};
    color: ${({ theme }) => theme.colors.secondaryText};
    margin-bottom: ${({ theme }) => theme.spacing.small};
  }

  input, select {
    margin-top: ${({ theme }) => theme.spacing.small};
    padding: ${({ theme }) => theme.spacing.small};
    border-radius: ${({ theme }) => theme.borderRadius};
    border: 1px solid ${({ theme }) => theme.colors.border};
  }
`;
