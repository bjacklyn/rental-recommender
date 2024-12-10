package com.rentalrecommender.dataprocessor.model;

import lombok.Data;

import org.bson.types.ObjectId;
import java.util.Collections;
import java.util.List;

@Data
public class Property {
    private ObjectId id;
    private String propertyUrl;
    private String propertyId;  
    private String listingId;
    private String mls;
    private String mlsId;
    private String status;

    private String text;
    private String style;

    private String fullStreetLine;
    private String street;
    private String unit;
    private String city;
    private String state;
    private String zipCode;

    private Integer beds = 0; 
    private Integer fullBaths = 0;
    private Integer halfBaths = 0;
    private Integer sqft = 0;
    private Integer yearBuilt = null;

    private Integer daysOnMls = 0;
    private Double listPrice = 0.0;
    private Double listPriceMin = null;
    private Double listPriceMax = null;
    private String listDate;
    private Double soldPrice = null;
    private String lastSoldDate;
    private Double assessedValue = null;
    private Double estimatedValue = null;
    private Boolean newConstruction = false;
    private Integer lotSqft = null;
    private Double pricePerSqft = 0.0;

    private Double latitude = null;
    private Double longitude = null;
    private String neighborhoods;
    private String county;
    private String fipsCode;

    private Integer stories = null;
    private Double hoaFee = null;
    private String parkingGarage;

    private String agentId;
    private String agentName;
    private String agentEmail;
    private String agentPhones;
    private String agentMlsSet;
    private String agentNrdsId;

    private String brokerId;
    private String brokerName;

    private String builderId;
    private String builderName;

    private String officeId;
    private String officeMlsSet;
    private String officeName;
    private String officeEmail;
    private String officePhones;

    private String nearbySchools;

    private String primaryPhoto;
    private List<String> altPhotos = Collections.emptyList();
}