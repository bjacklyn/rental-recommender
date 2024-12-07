import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { getFilteredListings } from "../../apis/listingApi";
import { FILTER_DEFAULTS } from "./constants";

// Async Thunk: Fetch listings based on filters
export const fetchListings = createAsyncThunk(
  "dashboard/fetchListings",
  async (filters, { rejectWithValue }) => {
    try {
      const data = await getFilteredListings(filters); // Use the API function from listingApi.js
      return data; // Return the array of properties
    } catch (error) {
      return rejectWithValue(error.message || "Failed to fetch listings");
    }
  }
);

const initialState = {
  filters: { ...FILTER_DEFAULTS },
  listings: [],
  chat: {
    messages: [],
    propertyContext: null,
  },
  isLoading: false,
  error: null,
  filterApplied: false,
};

const dashboardSlice = createSlice({
  name: "dashboard",
  initialState,
  reducers: {
    setFilters(state, action) {
      state.filters = { ...state.filters, ...action.payload };
    },
    applyFilters(state, action) {
      state.filters = { ...state.filters, ...action.payload };
      state.filterApplied = true;
    },
    resetFilters(state) {
      state.filters = { ...FILTER_DEFAULTS };
      state.filterApplied = false;
    },
    setChatContext(state, action) {
      state.chat.propertyContext = action.payload;
    },
    sendMessage(state, action) {
      state.chat.messages.push({ sender: "user", content: action.payload });
    },
    clearChat(state) {
      state.chat.messages = [];
      state.chat.propertyContext = null;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchListings.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(fetchListings.fulfilled, (state, action) => {
        state.isLoading = false;
        state.listings = action.payload; // Save the array of properties
      })
      .addCase(fetchListings.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload;
      });
  },
});

export const {
  setFilters,
  applyFilters,
  resetFilters,
  setChatContext,
  sendMessage,
  clearChat,
} = dashboardSlice.actions;

export default dashboardSlice.reducer;