import React, { useEffect } from "react";
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
import Chat from "../../components/chat/Chat";
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
  const chatMessages = useSelector(selectChatMessages);
  const chatContext = useSelector(selectChatContext);

  useEffect(() => {
    if (filterApplied) {
      dispatch(fetchListings(filters));
    }
  }, [filterApplied, JSON.stringify(filters), dispatch]);

  const handleFilterSubmit = (filters) => {
    dispatch(applyFilters(filters));
  };

  const handleSelectProperty = (property) => {
    dispatch(setChatContext(property));
  };

  const handleSendMessage = (message) => {
    dispatch(sendMessage(message));
  };

  return (
    <DashboardWrapper>
      <Header>
        <h1>Rental Recommender</h1>
      </Header>
      <Section>
        <Filter onFilter={handleFilterSubmit} initialValues={filters} />
      </Section>
      {filterApplied && (
        <LayoutWrapper>
          <div>
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
                  price: property.list_price_min
                    ? `$${property.list_price_min.toLocaleString()} - $${property.list_price_max.toLocaleString()}`
                    : "Price not available",
                  text: property.text,
                  url: property.property_url,
                }))}
                onItemClick={handleSelectProperty}
              />
            ) : (
              <Placeholder>No listings found. Try adjusting the filters!</Placeholder>
            )}
          </div>
          <div>
            <Chat
              messages={chatMessages}
              context={chatContext}
              onSendMessage={handleSendMessage}
              onClearChat={() => dispatch(clearChat())}
            />
          </div>
        </LayoutWrapper>
      )}
    </DashboardWrapper>
  );
};

export default Dashboard;
