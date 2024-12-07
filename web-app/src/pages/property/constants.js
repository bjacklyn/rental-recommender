export const selectPropertyDetails = (state) => state.property.property;
export const selectSimilarListings = (state) => state.property.similarListings;
export const selectPropertyLoading = (state) => state.property.isLoading;
export const selectPropertyError = (state) => state.property.error;

export const PROPERTY_DEFAULTS = {
  images: [],
  address: "Not Available",
  price: "Not Available",
  bedrooms: 0,
  bathrooms: 0,
  sqft: 0,
  description: "No description available",
  additionalDetails: [],
};