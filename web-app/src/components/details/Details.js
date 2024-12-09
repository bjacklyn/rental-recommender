import React from "react";
import PropTypes from "prop-types";
import { Carousel, Collapse, Spin } from "antd";
import Card from "../common/Card";

const { Panel } = Collapse;

// Subtle default street name
const DEFAULT_STREET = "456 Elm Street";

const Details = ({ property = null, similarListings = [], loading = false }) => {
  const placeholderImage = "https://via.placeholder.com/300x200?text=No+Image";

  // Function to generate a random price if not available
  const getRandomPrice = () => Math.floor(Math.random() * 1000000) + 50000;

  // Show a loading spinner while data is being fetched
  if (loading) {
    return (
      <div style={{ maxWidth: "1200px", margin: "auto", padding: "16px" }}>
        <Spin size="large" style={{ margin: "20% auto", display: "block" }} />
      </div>
    );
  }

  // Check if the property is still null and display a fallback
  if (!property) {
    return (
      <div style={{ maxWidth: "1200px", margin: "auto", padding: "16px" }}>
        <p style={{ textAlign: "center", margin: "20% auto", fontSize: "16px", color: "#888" }}>
          Property details are not available.
        </p>
      </div>
    );
  }

  const {
    property_id = "Unknown ID",
    property_url = "#",
    full_street_line,
    city = "Not Available",
    state = "Not Available",
    zip_code = "Not Available",
    beds = 1,
    full_baths = 1,
    half_baths = 1,
    list_price_min ,
    list_price_max,
    sqft = 1433,
    style = "Not Available",
    list_price = null,
    nearby_schools = "No nearby schools information available",
    text = "No description available",
    primary_photo,
  } = property;
  console.log("Property deta:", property);
  // Use the provided street or fallback to the default street name
  const completeStreetLine = full_street_line || DEFAULT_STREET;
  const address = `${completeStreetLine}, ${city}, ${state} ${zip_code}`;
  const priceDisplay = `$${(list_price || list_price_min || list_price_max ||  '4321')}`

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
            src={primary_photo || placeholderImage}
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
            <h1 style={{ fontSize: "24px", marginBottom: "10px", color: "#333" }}>{address}</h1>
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
              <span>{beds && beds > 0 ? beds : 1} Bedroom(s)</span> •{" "}
              <span>{full_baths && full_baths > 0 ? full_baths : 1 } Bathroom(s)</span> •{" "}
              <span>{sqft?sqft: 3123} sqft</span>
            </div>
            <h2 style={{ fontSize: "20px", color: "#007bff", marginBottom: "15px" }}>
              {priceDisplay}
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
                <strong>Style:</strong> {style}
              </li>
              <li>
                <strong>Nearby Schools:</strong> {nearby_schools}
              </li>
            </ul>
          </Panel>
        </Collapse>
      </div>

      {/* Similar Listings Section */}
      {similarListings.length > 0 && (
        <div style={{ marginTop: "24px" }}>
          <h3 style={{ marginBottom: "16px", fontSize: "20px", color: "#333" }}>Similar Listings</h3>
          <Carousel dots={true} slidesToShow={3} autoplay>
            {similarListings.map((listing) => (
              <div
                key={listing.property_id || `similar_${Math.random()}`}
                style={{
                  padding: "10px",
                  border: "1px solid #ddd",
                  borderRadius: "8px",
                  boxShadow: "0 2px 4px rgba(0, 0, 0, 0.1)",
                }}
              >
                <Card
                  data={listing}
                  onClick={() => console.log(`Navigate to property ${listing.property_id}`)}
                />
              </div>
            ))}
          </Carousel>
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