import axios from "axios";

const BASE_URL = "http://3.141.10.84:8080"

export const getRecomendedProperties = async (propertyId) => {
    try {
      const response = await axios.get(`${BASE_URL}/api/get-rental-recommendations/${propertyId}`);
      return response.data.properties;
    } catch (error) {
      throw error.response ? error.response.data : new Error("API Error");
    }
  };