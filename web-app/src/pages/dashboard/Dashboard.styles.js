import styled from "styled-components";

export const DashboardWrapper = styled.div`
  margin: 0 auto;
  padding: ${({ theme }) => theme.spacing.large};
  width: 90%;
  max-width: 1200px;
  min-width: 320px; /* Adjusted for better responsiveness */
  background-color: ${({ theme }) => theme.colors.primaryBackground};
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: ${({ theme }) => theme.borderRadius};
  box-shadow: ${({ theme }) => theme.boxShadow.default};
  overflow: auto; /* Ensures content inside can scroll if needed */
`;


export const Header = styled.header`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: ${({ theme }) => theme.spacing.large};
  padding: ${({ theme }) => theme.spacing.medium};
  background-color: ${({ theme }) => theme.colors.secondaryBackground};
  border-radius: ${({ theme }) => theme.borderRadius};
  box-shadow: ${({ theme }) => theme.boxShadow.default};

  h1 {
    font-size: 24px;
    color: ${({ theme }) => theme.colors.primaryText};
    margin: 0;
  }

  button {
    padding: ${({ theme }) => theme.spacing.small} ${({ theme }) => theme.spacing.medium};
    font-size: 14px;
    color: ${({ theme }) => theme.colors.primaryText};
    background-color: ${({ theme }) => theme.colors.primaryButton};
    border: none;
    border-radius: ${({ theme }) => theme.borderRadius};
    cursor: pointer;
    transition: ${({ theme }) => theme.transitions.default};

    &:hover {
      background-color: ${({ theme }) => theme.colors.secondaryButton};
    }
  }
`;

export const Section = styled.div`
  margin-bottom: ${({ theme }) => theme.spacing.large};
  padding: ${({ theme }) => theme.spacing.medium};
  background-color: ${({ theme }) => theme.colors.secondaryBackground};
  border-radius: ${({ theme }) => theme.borderRadius};
  box-shadow: ${({ theme }) => theme.boxShadow.default};
  overflow: auto; /* Ensures this section scrolls if its content overflows */
`;

export const LayoutWrapper = styled.div`
  display: flex;
  gap: ${({ theme }) => theme.spacing.large};

  > div {
    flex: 1;
    background-color: ${({ theme }) => theme.colors.primaryBackground};
    border: 1px solid ${({ theme }) => theme.colors.border};
    border-radius: ${({ theme }) => theme.borderRadius};
    padding: ${({ theme }) => theme.spacing.medium};
    box-shadow: ${({ theme }) => theme.boxShadow.default};
    overflow: hidden; /* Prevents unintended scroll in child containers */
  }

  @media (max-width: 768px) {
    flex-direction: column;
    overflow: visible; /* Ensures child elements stack properly */
  }
`;

export const LoadingMessage = styled.p`
  color: ${({ theme }) => theme.colors.primaryButton};
  font-weight: bold;
  text-align: center;
  font-size: 16px;
`;

export const Placeholder = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 200px;
  background-color: ${({ theme }) => theme.colors.secondaryBackground};
  border: 1px dashed ${({ theme }) => theme.colors.border};
  border-radius: ${({ theme }) => theme.borderRadius};
  font-size: 16px;
  color: ${({ theme }) => theme.colors.secondaryText};
  font-weight: ${({ theme }) => theme.typography.bodyFontWeight};
  overflow: hidden; /* Prevents clipping within this component */
  @media (max-width: 768px) {
    min-height: 150px; /* Adjust for smaller screens */
  }
`;