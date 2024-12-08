import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";

const CardWrapper = styled.div`
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: ${({ theme }) => theme.borderRadius};
  overflow: hidden;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s, box-shadow 0.3s;
  cursor: pointer;

  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
  }
`;

const Image = styled.img`
  width: 100%;
  height: 200px;
  object-fit: cover;
`;

const Info = styled.div`
  padding: 16px;
`;

const Title = styled.h2`
  font-size: 18px;
  margin-bottom: 8px;
  color: ${({ theme }) => theme.colors.text};
`;

const Price = styled.p`
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 8px;
  color: ${({ theme }) => theme.colors.primary};
`;

const Details = styled.p`
  font-size: 14px;
  color: ${({ theme }) => theme.colors.text};
  margin-bottom: 16px;
`;

const Button = styled.button`
  padding: 8px 16px;
  background-color: ${({ theme }) => theme.colors.primary};
  color: ${({ theme }) => theme.colors.textOnPrimary};
  border: none;
  border-radius: ${({ theme }) => theme.borderRadius};
  cursor: pointer;

  &:hover {
    background-color: ${({ theme }) => theme.colors.primaryHover};
  }
`;

const Card = ({ data, onClick }) => {
  const { primary_photo, title, price, bedrooms, bathrooms } = data;

  return (
    <CardWrapper onClick={onClick}>
      <Image src={primary_photo} alt={title} />
      <Info>
        <Title>{title}</Title>
        <Price>{price}</Price>
        <Details>{bedrooms} Beds • {bathrooms} Baths</Details>
        <Button>View Details</Button>
      </Info>
    </CardWrapper>
  );
};

Card.propTypes = {
  data: PropTypes.shape({
    image: PropTypes.string.isRequired,
    title: PropTypes.string.isRequired,
    price: PropTypes.string.isRequired,
    bedrooms: PropTypes.number.isRequired,
    bathrooms: PropTypes.number.isRequired,
  }).isRequired,
  onClick: PropTypes.func, // Optional click handler
};

Card.defaultProps = {
  onClick: () => {},
};

export default Card;