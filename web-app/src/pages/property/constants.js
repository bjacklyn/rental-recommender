export const selectPropertyDetails = (state) => state.property;
export const selectSimilarListings = (state) => state.property.similarListings;
export const selectPropertyLoading = (state) => state.property.isLoadingDetails; // Correct loading state for details
export const selectSimilarListingsLoading = (state) => state.property.isLoadingSimilarListings; // For similar listings
export const selectPropertyError = (state) => state.property.errorDetails; // Correct error state
export const selectSimilarListingsError = (state) => state.property.errorSimilarListings; // For similar listings errors


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