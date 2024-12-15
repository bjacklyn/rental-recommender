import React, { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import {
  fetchPropertyDetails,
  fetchSimilarListings,
} from "./state";
import {
  selectPropertyDetails,
  selectSimilarListings,
  selectPropertyLoading,
  selectPropertyError,
} from "./constants";
import Details from "../../components/details/Details";
import { PropertyWrapper } from "./Property.styles";

const Property = ({ propertyId }) => {
  const dispatch = useDispatch();
  const property = useSelector(selectPropertyDetails);
  const similarListings = useSelector(selectSimilarListings);
  const isLoading = useSelector(selectPropertyLoading);
  const error = useSelector(selectPropertyError);

  useEffect(() => {
    dispatch(fetchPropertyDetails([propertyId])); 
    dispatch(fetchSimilarListings(propertyId)); 
  }, [dispatch, propertyId]);

  // Debugging Logs
  console.log("Property Details:", property);
  console.log("Similar Listings:", similarListings);

  if (isLoading) return <p>Loading property details...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <PropertyWrapper>
      <Details property={property.propertyDetails} similarListings={similarListings} />
    </PropertyWrapper>
  );
};

export default Property;
