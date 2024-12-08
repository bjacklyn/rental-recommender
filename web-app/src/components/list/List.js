import React, { useState } from "react";
import PropTypes from "prop-types";
import { ListWrapper, EmptyMessage, PaginationWrapper } from "./List.styles";
import { Row, Col, Pagination } from "antd";
import Card from "../common/Card";
import { useNavigate } from "react-router-dom";

const ITEMS_PER_PAGE = 4;
const MAX_PAGES = 20;

const List = ({ items = [] }) => {
  const [currentPage, setCurrentPage] = useState(1); 
  const navigate = useNavigate();

  const handleItemClick = (id) => {
    navigate(`/listing/${id}`);
  };

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const paginatedItems = items.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  return (
    <ListWrapper>
      {items.length === 0 ? (
        <EmptyMessage>No listings available.</EmptyMessage>
      ) : (
        <>
          <Row gutter={[16, 16]}>
            {paginatedItems.map((item) => (
              <Col key={item.id} xs={24} sm={12} md={12} lg={12}>
                <Card data={item} onClick={() => handleItemClick(item.id)} />
              </Col>
            ))}
          </Row>
          <PaginationWrapper>
            <Pagination
              current={currentPage}
              pageSize={ITEMS_PER_PAGE}
              total={Math.min(items.length, ITEMS_PER_PAGE * MAX_PAGES)} // Limit total items to max pages
              onChange={handlePageChange}
              showSizeChanger={false} // Disable page size changer
            />
          </PaginationWrapper>
        </>
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
};

List.defaultProps = {
  items: [],
};

export default List;
