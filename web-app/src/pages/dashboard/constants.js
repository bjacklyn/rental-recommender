export const selectDashboardFilters = (state) => state.dashboard.filters;
export const selectDashboardFilterApplied = (state) => state.dashboard.filterApplied;

// Listings
export const selectDashboardListings = (state) => state.dashboard.listings;
export const selectDashboardLoading = (state) => state.dashboard.isLoading;

// Chat
export const selectChatMessages = (state) => state.dashboard.chat.messages;
export const selectChatContext = (state) => state.dashboard.chat.propertyContext;

// Default Filters
export const FILTER_DEFAULTS = {
  pincode: "",
  propertyType: "",
  bedrooms: 0,
  bathrooms: 0,
  sqft: [500, 5000], // Added square footage range
};