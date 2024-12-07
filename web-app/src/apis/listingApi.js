import axios from "axios";

const BASE_URL = process.env.REACT_APP_API_BASE_URL || "http://localhost:8000";

/**
 * Fetches filtered listings from the API.
 * @param {Object} filters - Filters to apply to the API request.
 * @returns {Promise<Array>} - List of properties from the API.
 */
export const getFilteredListings = async (filters) => {
  try {
    const response = await axios.get(`${BASE_URL}/api/v1/housing-properties`, {
      params: filters,
    });
    return response.data.properties; // Extract the 'properties' array
  } catch (error) {
    throw error.response ? error.response.data : new Error("API Error");
  }
};