package com.rentalrecommender.dataprocessor;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.rentalrecommender.dataprocessor.config.MongoDbConfig;
import com.rentalrecommender.dataprocessor.model.Property;
import com.rentalrecommender.dataprocessor.sink.PropertyMongoDbSink;
import org.bson.Document;
import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class PropertyMongoDbSinkIntegrationTest {

    private static MongoCollection<Document> collection;
    private static PropertyMongoDbSink mongoDbSink;

    @BeforeAll
    public static void setupAll() {
        MongoDatabase database = MongoDbConfig.getDatabase();
        collection = database.getCollection("sample");
        mongoDbSink = new PropertyMongoDbSink();
        System.out.println("MongoDB setup complete: Database = " + MongoDbConfig.getDatabase().getName() +
                ", Collection = sample");
    }

    @BeforeEach
    public void setup() {
        System.out.println("Starting test with collection state intact.");
    }

    @Test
    public void testMongoDbSinkInsertOrUpdate() {
        Property property = createTestProperty("test-12345", "123 Initial Street");
        System.out.println("Testing insert or update for property: " + property);

        mongoDbSink.invoke(property, null);

        Document retrievedDocument = collection.find(Filters.eq("propertyId", "test-12345")).first();

        assertNotNull(retrievedDocument, "Document should exist in the collection after the operation.");
        assertEquals("test-12345", retrievedDocument.getString("propertyId"));
        assertEquals("123 Initial Street", retrievedDocument.getString("street"));

        property.setStreet("456 Updated Street");
        mongoDbSink.invoke(property, null);

        retrievedDocument = collection.find(Filters.eq("propertyId", "test-12345")).first();

        assertNotNull(retrievedDocument, "Document should still exist after the update operation.");
        assertEquals("test-12345", retrievedDocument.getString("propertyId"));
        assertEquals("456 Updated Street", retrievedDocument.getString("street"));
    }

    @AfterEach
    public void tearDown() {
        collection.deleteOne(Filters.eq("propertyId", "test-12345"));
        System.out.println("Test data cleaned up.");
    }

    @AfterAll
    public static void tearDownAll() {
        MongoDbConfig.getMongoClient().close();
        System.out.println("MongoDB connection closed.");
    }

    private Property createTestProperty(String propertyId, String street) {
        Property property = new Property();
        property.setPropertyId(propertyId);
        property.setStreet(street);
        return property;
    }
}