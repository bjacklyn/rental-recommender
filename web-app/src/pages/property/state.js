import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { getPropertyDetails } from "../../apis/listingApi"; 
import { getRecomendedProperties } from "../../apis/recommenderApi";


// Async Thunk to Fetch Property Details (POST Endpoint)
export const fetchPropertyDetails = createAsyncThunk(
  "property/fetchPropertyDetails",
  async (propertyIds, { rejectWithValue }) => {
    try {
      const data = await getPropertyDetails(propertyIds); // Call the POST endpoint
      return data; // Return property details
    } catch (error) {
      console.error("Error fetching property details:", error); // Debugging info
      return rejectWithValue(
        error.response?.data || error.message || "Failed to fetch property details"
      );
    }
  }
);

// Async Thunk to Fetch Recommended Listings


export const fetchSimilarListings = createAsyncThunk(
  "property/fetchSimilarListings",
  async (propertyId, { rejectWithValue }) => {
    try {
      const data = await getRecomendedProperties(propertyId);
      return data; // Return property details
    } catch (error) {
      console.error("Error fetching property details:", error); // Debugging info
      return rejectWithValue(
        error.response?.data || error.message || "Failed to fetch property details"
      );
    }
  }
);


const initialState = {
  propertyDetails: null, // Stores the fetched property details
  similarListings: [], // Stores similar property listings
  isLoadingDetails: false, // Loading state for property details
  isLoadingSimilarListings: false, // Loading state for similar listings
  errorDetails: null, // Error state for property details API
  errorSimilarListings: null, // Error state for similar listings API
};

const propertySlice = createSlice({
  name: "property",
  initialState,
  reducers: {
    clearPropertyDetails(state) {
      state.propertyDetails = null;
      state.isLoadingDetails = false;
      state.errorDetails = null;
    },
    clearSimilarListings(state) {
      state.similarListings = [];
      state.isLoadingSimilarListings = false;
      state.errorSimilarListings = null;
    },
    clearAll(state) {
      return initialState; // Reset the entire state
    },
  },
  extraReducers: (builder) => {
    builder
      // Handle fetchPropertyDetails (POST Endpoint)
      .addCase(fetchPropertyDetails.pending, (state) => {
        state.isLoadingDetails = true;
        state.errorDetails = null;
      })
      .addCase(fetchPropertyDetails.fulfilled, (state, action) => {
        state.isLoadingDetails = false;
        state.propertyDetails = action.payload && action.payload[0];
      })
      .addCase(fetchPropertyDetails.rejected, (state, action) => {
        state.isLoadingDetails = false;
        state.errorDetails = action.payload;
      })
      // Handle fetchSimilarListings
      .addCase(fetchSimilarListings.pending, (state) => {
        state.isLoadingSimilarListings = true;
        state.errorSimilarListings = null;
      })
      .addCase(fetchSimilarListings.fulfilled, (state, action) => {
        state.isLoadingSimilarListings = false;
        state.similarListings = action.payload;
      })
      .addCase(fetchSimilarListings.rejected, (state, action) => {
        state.isLoadingSimilarListings = false;
        state.errorSimilarListings = action.payload;
      });
  },
});

export const { clearPropertyDetails, clearSimilarListings, clearAll } = propertySlice.actions;

export default propertySlice.reducer;
