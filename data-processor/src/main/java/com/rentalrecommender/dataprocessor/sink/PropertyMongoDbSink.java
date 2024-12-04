package com.rentalrecommender.dataprocessor.sink;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.ReplaceOptions;
import com.rentalrecommender.dataprocessor.config.MongoDbConfig;
import com.rentalrecommender.dataprocessor.model.Property;
import org.apache.flink.streaming.api.functions.sink.SinkFunction;
import org.bson.Document;

/**
 * MongoDB sink for writing Property objects to MongoDB with upsert functionality.
 */
@SuppressWarnings("deprecation")
public class PropertyMongoDbSink implements SinkFunction<Property> {
    private static final String COLLECTION_NAME = "sample";

    private final MongoCollection<Document> collection;


    public PropertyMongoDbSink() {
        MongoDatabase database = MongoDbConfig.getDatabase();
        this.collection = database.getCollection(COLLECTION_NAME);
    }

    @Override
    public void invoke(Property value, Context context) {
        // Convert Property object to BSON Document
        Document document = new Document()
                .append("propertyUrl", value.getPropertyUrl())
                .append("propertyId", value.getPropertyId())
                .append("listingId", value.getListingId())
                .append("mls", value.getMls())
                .append("mlsId", value.getMlsId())
                .append("status", value.getStatus())
                .append("text", value.getText())
                .append("style", value.getStyle())
                .append("fullStreetLine", value.getFullStreetLine())
                .append("street", value.getStreet())
                .append("unit", value.getUnit())
                .append("city", value.getCity())
                .append("state", value.getState())
                .append("zipCode", value.getZipCode())
                .append("beds", value.getBeds())
                .append("fullBaths", value.getFullBaths())
                .append("halfBaths", value.getHalfBaths())
                .append("sqft", value.getSqft())
                .append("yearBuilt", value.getYearBuilt())
                .append("daysOnMls", value.getDaysOnMls())
                .append("listPrice", value.getListPrice())
                .append("listPriceMin", value.getListPriceMin())
                .append("listPriceMax", value.getListPriceMax())
                .append("listDate", value.getListDate())
                .append("soldPrice", value.getSoldPrice())
                .append("lastSoldDate", value.getLastSoldDate())
                .append("assessedValue", value.getAssessedValue())
                .append("estimatedValue", value.getEstimatedValue())
                .append("newConstruction", value.getNewConstruction())
                .append("lotSqft", value.getLotSqft())
                .append("pricePerSqft", value.getPricePerSqft())
                .append("latitude", value.getLatitude())
                .append("longitude", value.getLongitude())
                .append("neighborhoods", value.getNeighborhoods())
                .append("county", value.getCounty())
                .append("fipsCode", value.getFipsCode())
                .append("stories", value.getStories())
                .append("hoaFee", value.getHoaFee())
                .append("parkingGarage", value.getParkingGarage())
                .append("agentId", value.getAgentId())
                .append("agentName", value.getAgentName())
                .append("agentEmail", value.getAgentEmail())
                .append("agentPhones", value.getAgentPhones())
                .append("agentMlsSet", value.getAgentMlsSet())
                .append("agentNrdsId", value.getAgentNrdsId())
                .append("brokerId", value.getBrokerId())
                .append("brokerName", value.getBrokerName())
                .append("builderId", value.getBuilderId())
                .append("builderName", value.getBuilderName())
                .append("officeId", value.getOfficeId())
                .append("officeMlsSet", value.getOfficeMlsSet())
                .append("officeName", value.getOfficeName())
                .append("officeEmail", value.getOfficeEmail())
                .append("nearbySchools", value.getNearbySchools())
                .append("primaryPhoto", value.getPrimaryPhoto())
                .append("altPhotos", value.getAltPhotos());

        // Perform the upsert operation
        ReplaceOptions options = new ReplaceOptions().upsert(true);
        collection.replaceOne(Filters.eq("propertyId", value.getPropertyId()), document, options);
    }
}
