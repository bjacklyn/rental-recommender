import React from "react";
import PropTypes from "prop-types";
import {
  DetailsContainer,
  HeaderSection,
  ImageWrapper,
  InfoWrapper,
  DetailsSection,
  CarouselSection,
  ContactButton,
} from "./Details.styles";
import { Carousel, Collapse } from "antd";
import Card from "../common/Card";

const { Panel } = Collapse;

const Details = ({ property = {}, similarListings = [] }) => {
  const {
    images = [],
    address = "Not Available",
    price = "Not Available",
    bedrooms = 0,
    bathrooms = 0,
    sqft = 0,
    description = "No description available",
    additionalDetails = [],
  } = property;

  return (
    <DetailsContainer>
      {/* Header Section */}
      <HeaderSection>
        <ImageWrapper>
          <Carousel autoplay>
            {images.map((src, index) => (
              <div key={index}>
                <img src={src} alt={`Slide ${index + 1}`} />
              </div>
            ))}
          </Carousel>
        </ImageWrapper>
        <InfoWrapper>
          <h1>{address}</h1>
          <div className="quick-details">
            <span>{bedrooms} Bedroom</span> • <span>{bathrooms} Bathroom</span> • <span>{sqft} sqft</span>
          </div>
          <h2>{price}/mo</h2>
          <ContactButton>Contact</ContactButton>
        </InfoWrapper>
      </HeaderSection>

      {/* Details Section */}
      <DetailsSection>
        <Collapse defaultActiveKey={["1"]}>
          <Panel header="Details" key="1">
            <p>{description}</p>
            <ul>
              {additionalDetails.map((detail, index) => (
                <li key={index}>{detail}</li>
              ))}
            </ul>
          </Panel>
        </Collapse>
      </DetailsSection>

      {/* Similar Listings Section */}
      <CarouselSection>
        <h3>Similar Listings</h3>
        <Carousel dots={false} slidesToShow={3} autoplay>
          {similarListings.map((listing) => (
            <div key={listing.id}>
              <Card data={listing} onClick={() => console.log(`Navigate to property ${listing.id}`)} />
            </div>
          ))}
        </Carousel>
      </CarouselSection>
    </DetailsContainer>
  );
};

Details.propTypes = {
  property: PropTypes.shape({
    images: PropTypes.arrayOf(PropTypes.string).isRequired,
    address: PropTypes.string.isRequired,
    price: PropTypes.string.isRequired,
    bedrooms: PropTypes.number.isRequired,
    bathrooms: PropTypes.number.isRequired,
    sqft: PropTypes.number.isRequired,
    description: PropTypes.string.isRequired,
    additionalDetails: PropTypes.arrayOf(PropTypes.string).isRequired,
  }).isRequired,
  similarListings: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.string.isRequired,
      image: PropTypes.string.isRequired,
      title: PropTypes.string.isRequired,
      price: PropTypes.string.isRequired,
      bedrooms: PropTypes.number.isRequired,
      bathrooms: PropTypes.number.isRequired,
    })
  ).isRequired,
};

export default Details;