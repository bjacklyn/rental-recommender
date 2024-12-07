import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";

// Async Thunk to Fetch Property Data
export const fetchProperty = createAsyncThunk(
  "property/fetchProperty",
  async (propertyId, { rejectWithValue }) => {
    try {
      const response = await fetch(`/api/properties/${propertyId}`);
      if (!response.ok) {
        throw new Error("Failed to fetch property data");
      }
      return await response.json();
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);

// Async Thunk to Fetch Similar Listings
export const fetchSimilarListings = createAsyncThunk(
  "property/fetchSimilarListings",
  async (propertyId, { rejectWithValue }) => {
    try {
      const response = await fetch(`/api/properties/${propertyId}/similar`);
      if (!response.ok) {
        throw new Error("Failed to fetch similar listings");
      }
      return await response.json();
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);

const initialState = {
  property: null,
  similarListings: [],
  isLoading: false,
  error: null,
};

const propertySlice = createSlice({
  name: "property",
  initialState,
  reducers: {
    clearProperty(state) {
      state.property = null;
      state.similarListings = [];
      state.isLoading = false;
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchProperty.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(fetchProperty.fulfilled, (state, action) => {
        state.isLoading = false;
        state.property = action.payload;
      })
      .addCase(fetchProperty.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload;
      })
      .addCase(fetchSimilarListings.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(fetchSimilarListings.fulfilled, (state, action) => {
        state.isLoading = false;
        state.similarListings = action.payload;
      })
      .addCase(fetchSimilarListings.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload;
      });
  },
});

export const { clearProperty } = propertySlice.actions;

export default propertySlice.reducer;