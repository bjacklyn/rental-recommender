import axios from "axios";

const BASE_URL = "http://18.119.153.150:8010";

/**
 * Fetches filtered listings from the API (GET Endpoint).
 * @param {Object} filters - Filters to apply to the API request.
 * @returns {Promise<Array>} - List of properties from the API.
 */
export const getFilteredListings = async (filters) => {
  try {
    const response = await axios.get(`${BASE_URL}/api/v1/housing-properties`, {
      params: {
        zip_code: filters.pincode,
        min_beds: filters.min_beds,
        max_beds: filters.max_beds,
        min_sqft: filters.min_sqft,
        max_sqft: filters.max_sqft,
      },
    });
    return response.data.properties; // Extract the 'properties' array
  } catch (error) {
    throw error.response ? error.response.data : new Error("API Error");
  }
};

/**
 * Fetches specific property details (POST Endpoint).
 * @param {Array<number>} propertyIds - List of property IDs.
 * @returns {Promise<Object>} - Response with property details.
 */
export const getPropertyDetails = async (propertyIds) => {
  try {
    const response = await axios.post(`${BASE_URL}/api/v1/housing-properties`, {
      property_ids: propertyIds,
    });
    return response.data.properties;
  } catch (error) {
    throw error.response ? error.response.data : new Error("API Error");
  }
};
