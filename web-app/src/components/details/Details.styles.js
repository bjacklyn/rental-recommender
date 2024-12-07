import styled from "styled-components";

export const DetailsContainer = styled.div`
  max-width: 1200px;
  margin: auto;
  padding: 16px;
`;

export const HeaderSection = styled.div`
  display: flex;
  gap: 16px;
  margin-bottom: 24px;

  @media (max-width: 768px) {
    flex-direction: column;
  }
`;

export const ImageWrapper = styled.div`
  flex: 2;

  .ant-carousel img {
    width: 100%;
    height: auto;
    border-radius: ${({ theme }) => theme.borderRadius};
  }
`;

export const InfoWrapper = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;

  h1 {
    font-size: 24px;
    margin-bottom: 8px;
    color: ${({ theme }) => theme.colors.text};
  }

  .quick-details {
    font-size: 14px;
    color: ${({ theme }) => theme.colors.textAlt};
    margin-bottom: 16px;

    span {
      margin-right: 8px;
    }
  }

  h2 {
    font-size: 20px;
    color: ${({ theme }) => theme.colors.primary};
    margin-bottom: 16px;
  }
`;

export const ContactButton = styled.button`
  background-color: ${({ theme }) => theme.colors.primary};
  color: ${({ theme }) => theme.colors.textOnPrimary};
  border: none;
  padding: 8px 16px;
  font-size: 16px;
  border-radius: ${({ theme }) => theme.borderRadius};
  cursor: pointer;

  &:hover {
    background-color: ${({ theme }) => theme.colors.primaryHover};
  }
`;

export const DetailsSection = styled.div`
  margin-bottom: 24px;

  .ant-collapse {
    border: 1px solid ${({ theme }) => theme.colors.border};
    border-radius: ${({ theme }) => theme.borderRadius};
  }
`;

export const CarouselSection = styled.div`
  margin-top: 24px;

  h3 {
    font-size: 20px;
    margin-bottom: 16px;
  }

  .ant-carousel .slick-slide {
    padding: 8px;
  }
`;