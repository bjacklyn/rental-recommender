import React from "react";
import PropTypes from "prop-types";
import styled from "styled-components";
import { useNavigate } from "react-router-dom";

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
  if (data.property) {
    data = data.property;
  }
  const navigate = useNavigate();

  const handleItemClick = () => {
    navigate(`/web-app/listing/${data.property_id}`);
  };

  const { primary_photo, title, price, bedrooms, bathrooms, } = data;
  console.log(data);

  let calculated_beds = 0, calculated_baths = 0;
  if (!isNaN(data.full_baths)) {
    calculated_baths = data.full_baths;
  }
  if (!isNaN(data.half_baths)) {
    calculated_baths = calculated_baths + data.half_baths / 2;
  }
  if (!isNaN(data.beds)) {
    calculated_beds = data.beds;
  }
  if (calculated_beds < 1) {
    calculated_beds = 1;
  }
  if (calculated_baths < 1) {
    calculated_baths = 1;
  }

  console.log(data)

  let priceVal = data.list_price || data.list_price_min || data.list_price_max;

  let address_line = data.full_street_line || data.address;

  return (
    <CardWrapper onClick={onClick}>
      <Image src={primary_photo} onError={({ currentTarget }) => {
        currentTarget.onerror = null; // prevents looping
        currentTarget.src = "https://cdn.prod.website-files.com/5ec257673687b0d0f7d61e67/60741e003536396624b511fe_owning-empty-house-selling-empty-house-main-image-yes-homebuyers.jpeg";
      }}
        alt={title} />
      <Info>
        <Title>{address_line}</Title>
        <Price>{`$${priceVal}`}</Price>
        <Details>{calculated_beds} Beds • {calculated_baths} Baths</Details>
        <Details>Property Id: {data.property_id}</Details>
        <Button onClick={handleItemClick}>View Details</Button>
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
  onClick: () => { },
};

export default Card;