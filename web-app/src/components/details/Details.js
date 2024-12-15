import React, { useState } from "react";
import PropTypes from "prop-types";
import { Collapse } from "antd";
import Card from "../common/Card";
import styled from "styled-components";

const { Panel } = Collapse;

const GridWrapper = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 24px;
  margin-top: 24px;
`;

const ViewMoreButton = styled.button`
  display: block;
  margin: 24px auto;
  padding: 10px 20px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-size: 16px;
  font-weight: 500;

  &:hover {
    background-color: #0056b3;
  }
`;

const Details = ({ property, similarListings, loading }) => {
  const [showAll, setShowAll] = useState(false);
  if(!property || loading) return <p>Loading property details...</p>;

  const {
    property_id,
    property_url,
    full_street_line,
    city,
    state,
    zip_code,
    beds,
    full_baths,
    half_baths,
    sqft,
    style,
    list_price,
    nearby_schools,
    text,
    primary_photo,
  } = property;


  let calculated_beds = 0, calculated_baths = 0, calculated_sqft = 1533; 
  if(!isNaN(property.full_baths)){
    calculated_baths = property.full_baths;
  }
  if(!isNaN(property.half_baths)){
    calculated_baths = calculated_baths + property.half_baths/2;
  }
  if(!isNaN(property.beds)){
    calculated_beds = property.beds;
  }
  if(calculated_beds < 1){
    calculated_beds = 1;
  }
  if(calculated_baths < 1){
    calculated_baths = 1;
  }
  if(!isNaN(property.sqft)){
    calculated_sqft = property.sqft;
  }
  
  let priceVal = property.list_price || property.list_price_min || property.list_price_max;

  let address_line = property.full_street_line || property.address;

  const displayedListings = showAll ? similarListings : similarListings.slice(0, 3);

  return (
    <div style={{ maxWidth: "1200px", margin: "auto", padding: "16px" }}>
      {/* Header Section */}
      <div
        style={{
          display: "flex",
          flexDirection: "row",
          gap: "16px",
          marginBottom: "24px",
          flexWrap: "wrap",
        }}
      >
        {/* Image Section */}
        <div style={{ flex: "2", minWidth: "300px" }}>
          <img
            src={primary_photo}
            alt="Property"
            style={{
              width: "100%",
              height: "auto",
              objectFit: "cover",
              borderRadius: "8px",
              boxShadow: "0 4px 6px rgba(0, 0, 0, 0.1)",
            }}
          />
        </div>

        {/* Info Section */}
        <div
          style={{
            flex: "1",
            display: "flex",
            flexDirection: "column",
            justifyContent: "space-between",
            minWidth: "280px",
          }}
        >
          <div>
            <h1 style={{ fontSize: "24px", marginBottom: "10px", color: "#333" }}>{full_street_line}</h1>
            <div
              style={{
                fontSize: "14px",
                color: "#555",
                marginBottom: "15px",
                display: "flex",
                gap: "8px",
                flexWrap: "wrap",
              }}
            >
              <span>{calculated_beds} Bedroom(s)</span> •{" "}
              <span>{calculated_baths} Bathroom(s)</span>
              <span>{calculated_sqft > 0 ? `• ${calculated_sqft} sqft` : ''}</span>
            </div>
            <h2 style={{ fontSize: "20px", color: "#007bff", marginBottom: "15px" }}>
              {priceVal ? `$${priceVal}` : "Unknown"}
            </h2>
          </div>
          <a
            href={property_url}
            target="_blank"
            rel="noopener noreferrer"
            style={{
              textDecoration: "none",
              display: "inline-block",
              padding: "10px 20px",
              backgroundColor: "#007bff",
              color: "#fff",
              borderRadius: "8px",
              textAlign: "center",
              fontSize: "16px",
              fontWeight: "500",
            }}
          >
            View Listing
          </a>
        </div>
      </div>

      {/* Details Section */}
      <div style={{ marginBottom: "24px" }}>
        <Collapse
          defaultActiveKey={["1", "2"]}
          style={{
            borderRadius: "8px",
            overflow: "hidden",
            boxShadow: "0 2px 4px rgba(0, 0, 0, 0.1)",
          }}
        >
          <Panel header="Description" key="1" style={{ fontSize: "16px" }}>
            <p style={{ margin: 0 }}>{text}</p>
          </Panel>
          <Panel header="Property Details" key="2" style={{ fontSize: "16px" }}>
            <ul style={{ paddingLeft: "20px", margin: 0 }}>
              <li>
                <strong>Style:</strong> {property.style}
              </li>
              {nearby_schools && (
                <li>
                  <strong>Nearby Schools:</strong> {nearby_schools}
                </li>
              )}
            </ul>
          </Panel>
        </Collapse>
      </div>

      {/* Similar Listings Section */}
      {similarListings.length > 0 && (
        <div>
          <h3 style={{ marginBottom: "16px", fontSize: "20px", color: "#333" }}>Similar Listings</h3>
          <GridWrapper>
            {displayedListings.map((listing) => (
              <Card
                key={listing.property_id || `similar_${Math.random()}`}
                data={listing}
                onClick={() => console.log(`Navigate to property ${listing.property_id}`)}
              />
            ))}
          </GridWrapper>
          {!showAll && similarListings.length > 3 && (
            <ViewMoreButton onClick={() => setShowAll(true)}>
              View More
            </ViewMoreButton>
          )}
        </div>
      )}
    </div>
  );
};

Details.propTypes = {
  property: PropTypes.shape({
    property_id: PropTypes.number,
    property_url: PropTypes.string,
    full_street_line: PropTypes.string,
    city: PropTypes.string,
    state: PropTypes.string,
    zip_code: PropTypes.string,
    beds: PropTypes.number,
    full_baths: PropTypes.number,
    half_baths: PropTypes.number,
    sqft: PropTypes.number,
    style: PropTypes.string,
    list_price: PropTypes.number,
    nearby_schools: PropTypes.string,
    text: PropTypes.string,
    primary_photo: PropTypes.string,
  }),
  similarListings: PropTypes.arrayOf(
    PropTypes.shape({
      property_id: PropTypes.number,
      property_url: PropTypes.string,
      city: PropTypes.string,
      state: PropTypes.string,
      list_price: PropTypes.number,
    })
  ),
  loading: PropTypes.bool,
};

export default Details;