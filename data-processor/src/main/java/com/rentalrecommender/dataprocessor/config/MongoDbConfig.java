package com.rentalrecommender.dataprocessor.config;

import com.mongodb.MongoClientSettings;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import lombok.Getter;

public class MongoDbConfig {

    private static final String CONNECTION_STRING = "mongodb://dev:MongoDBDev@18.119.153.150:27017/dev?authSource=dev";
    private static final String DATABASE_NAME = "dev";

    @Getter
    private static MongoClient mongoClient;

    @Getter
    private static MongoDatabase database;

    static {
        // Initialize MongoDB client and database
        mongoClient = MongoClients.create(MongoClientSettings.builder()
                .applyConnectionString(new com.mongodb.ConnectionString(CONNECTION_STRING))
                .build());

        database = mongoClient.getDatabase(DATABASE_NAME);
    }
}