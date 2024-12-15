import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import {
  applyFilters,
  fetchListings,
  setChatContext,
  sendMessage,
  clearChat,
} from "./state";
import {
  selectDashboardFilters,
  selectDashboardFilterApplied,
  selectDashboardListings,
  selectDashboardLoading,
  selectChatMessages,
  selectChatContext,
} from "./constants";
import Filter from "../../components/filter/Filter";
import List from "../../components/list/List";
import {
  DashboardWrapper,
  Header,
  LayoutWrapper,
  Section,
  LoadingMessage,
  Placeholder,
} from "./Dashboard.styles";



const Dashboard = ({ onSignOut }) => {
  const dispatch = useDispatch();
  const filters = useSelector(selectDashboardFilters);
  const filterApplied = useSelector(selectDashboardFilterApplied);
  const listings = useSelector(selectDashboardListings) || [];
  const isLoading = useSelector(selectDashboardLoading);

  useEffect(() => {
    if (filterApplied) {
      dispatch(fetchListings(filters));
    }
  }, [filterApplied, filters, dispatch]);


  const handleFilterSubmit = (filterParams) => {
    dispatch(applyFilters(filterParams));
  };

  const handleSelectProperty = (property) => {
    dispatch(setChatContext(property));
  };



  return (
    <DashboardWrapper>
      <Header>
        <h1>Rental Recommender</h1>
      </Header>
      <Section>
        <Filter
          onFilter={handleFilterSubmit}
          initialValues={{
            pincode: filters.pincode || "",
            propertyType: filters.propertyType || "apartment",
            bedrooms: filters.min_beds && filters.max_beds ? [filters.min_beds, filters.max_beds] : [1, 3],
            sqft: filters.min_sqft && filters.max_sqft ? [filters.min_sqft, filters.max_sqft] : [0, 2500],
          }}
        />
      </Section>
      {filterApplied && (
        <LayoutWrapper>
            {isLoading ? (
              <LoadingMessage>Loading listings...</LoadingMessage>
            ) : listings.length > 0 ? (
              <List
                items={listings.map((property) => ({
                  id: property.property_id,
                  address: property.full_street_line,
                  city: property.city,
                  state: property.state,
                  zip: property.zip_code,
                  property: property,
                  data: property.list_price
                    ? '$' + `${property.list_price}`
                    : "$1300",
                  text: property.text,
                  url: property.property_url,
                  bathrooms: property.full_baths,
                  bedrooms: property.beds,
                  primary_photo: property.primary_photo
                }))}
                onItemClick={handleSelectProperty}
              />
            ) : (
              <Placeholder>No listings found. Try adjusting the filters!</Placeholder>
            )}

        </LayoutWrapper>
      )}
    </DashboardWrapper>
  );
};

export default Dashboard;