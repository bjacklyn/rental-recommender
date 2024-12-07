import React, { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import {
  fetchProperty,
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
    dispatch(fetchProperty(propertyId));
    dispatch(fetchSimilarListings(propertyId));
  }, [dispatch, propertyId]);

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error: {error}</p>;

  return (
    <PropertyWrapper>
      <Details property={property} similarListings={similarListings} />
    </PropertyWrapper>
  );
};

export default Property;