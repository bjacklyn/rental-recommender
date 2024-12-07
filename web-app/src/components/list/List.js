import React from "react";
import PropTypes from "prop-types";
import { ListWrapper, EmptyMessage } from "./List.styles";
import { Row, Col } from "antd";
import Card from "../common/Card";

const List = ({ items = [], onItemClick }) => {
  return (
    <ListWrapper>
      {items.length === 0 ? (
        <EmptyMessage>No listings available.</EmptyMessage>
      ) : (
        <Row gutter={[16, 16]}>
          {items.map((item) => (
            <Col key={item.id} xs={24} sm={12} md={8} lg={6}>
              <Card data={item} onClick={() => onItemClick(item.id)} />
            </Col>
          ))}
        </Row>
      )}
    </ListWrapper>
  );
};

List.propTypes = {
  items: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.string.isRequired,
      image: PropTypes.string.isRequired,
      title: PropTypes.string.isRequired,
      price: PropTypes.string.isRequired,
      bedrooms: PropTypes.number.isRequired,
      bathrooms: PropTypes.number.isRequired,
    })
  ).isRequired,
  onItemClick: PropTypes.func, // Callback when an item is clicked
};

List.defaultProps = {
  items: [],
  onItemClick: () => {},
};

export default List;