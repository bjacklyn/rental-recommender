import styled from "styled-components";

export const DetailsContainer = styled.div`
  max-width: 1200px;
  margin: auto;
  padding: 16px;

  @media (max-width: 768px) {
    padding: 12px;
  }
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
  min-width: 300px;

  img {
    width: 100%;
    height: 300px; /* Fixed height */
    object-fit: cover;
    border-radius: ${({ theme }) => theme.borderRadius};
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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

export const DetailsSection = styled.div`
  margin-bottom: 24px;

  .ant-collapse {
    border: 1px solid ${({ theme }) => theme.colors.border};
    border-radius: ${({ theme }) => theme.borderRadius};
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }

  .ant-collapse-header {
    font-size: 16px;
    font-weight: 500;
  }

  .ant-collapse-content {
    padding: 12px 16px;
  }
`;

export const CarouselSection = styled.div`
  margin-top: 24px;

  h3 {
    font-size: 20px;
    margin-bottom: 16px;
    color: ${({ theme }) => theme.colors.text};
  }

  .ant-carousel {
    .slick-slide {
      padding: 8px;
      transition: transform 0.3s ease;

      &:hover {
        transform: scale(1.02);
      }
    }

    .slick-dots li button {
      background-color: ${({ theme }) => theme.colors.textAlt};
    }

    .slick-dots li.slick-active button {
      background-color: ${({ theme }) => theme.colors.primary};
    }
  }
`;