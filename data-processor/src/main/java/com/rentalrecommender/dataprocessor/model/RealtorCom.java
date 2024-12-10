package com.rentalrecommender.dataprocessor.model;

import lombok.Data;

import java.util.List;

@Data
public class RealtorCom {

    private PropertyInfo propertyInfo;
    private Address address;
    private Description description;
    private ListingDetails listingDetails;
    private Location location;
    private AgentInfo agentInfo;
    private BrokerInfo brokerInfo;
    private BuilderInfo builderInfo;
    private OfficeInfo officeInfo;

    @Data
    public static class PropertyInfo {
        private String propertyId;  // Mandatory
        private String propertyUrl;
        private String listingId;
        private String mls;
        private String mlsId;
        private String status;
    }

    @Data
    public static class Address {
        private String street;
        private String unit;
        private String city;
        private String state;
        private String zipCode;
    }

    @Data
    public static class Description {
        private String style;
        private Integer beds;
        private Integer fullBaths;
        private Integer halfBaths;
        private Integer sqft;
        private Integer yearBuilt;
        private Integer stories;
        private Boolean garage;
        private Integer lotSqft;
        private List<String> altPhotos; 
        private String text;          
    }

    @Data
    public static class ListingDetails {
        private Integer daysOnMls;
        private Double listPrice;
        private Double listPriceMin;
        private Double listPriceMax;
        private String listDate;
        private String pendingDate;
        private Double soldPrice;
        private String lastSoldDate;
        private Double pricePerSqft;
        private Boolean newConstruction;
        private Double hoaFee;
    }

    @Data
    public static class Location {
        private Double latitude;
        private Double longitude;
        private String neighborhoods;
        private String county;
        private String fipsCode;
    }

    @Data
    public static class AgentInfo {
        private String agentId;
        private String agentName;
        private String agentEmail;
        private List<String> agentPhones; 
        private String agentMlsSet;
        private String agentNrdsId;
    }

    @Data
    public static class BrokerInfo {
        private String brokerId;
        private String brokerName ;   }

    @Data
    public static class BuilderInfo {
        private String builderId;
        private String builderName;
    }

    @Data
    public static class OfficeInfo {
        private String officeId;
        private String officeName;
        private List<String> officePhones;
        private String officeEmail;
        private String officeMlsSet;
    }

    @Data
    public static class Phone {
        private String number;
        private String type;
        private Boolean primary;
        private String ext; 
    }
}