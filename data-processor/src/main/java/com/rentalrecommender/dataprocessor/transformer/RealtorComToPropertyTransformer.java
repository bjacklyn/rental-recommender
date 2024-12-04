package com.rentalrecommender.dataprocessor.transformer;

import com.rentalrecommender.dataprocessor.model.Property;
import com.rentalrecommender.dataprocessor.model.RealtorCom;

import java.io.Serializable;

public class RealtorComToPropertyTransformer  implements Serializable {
    private static final long serialVersionUID = 123423235624L;

    /**
     * Transforms a RealtorCom object into a Property object.
     *
     * @param realtorCom The RealtorCom object to transform.
     * @return A Property object populated with data from the RealtorCom object.
     */
    public Property transform(RealtorCom realtorCom) {
        Property property = new Property();

        // Map basic property information
        if (realtorCom.getPropertyInfo() != null) {
            property.setPropertyId(realtorCom.getPropertyInfo().getPropertyId());
            property.setPropertyUrl(realtorCom.getPropertyInfo().getPropertyUrl());
            property.setListingId(realtorCom.getPropertyInfo().getListingId());
            property.setMls(realtorCom.getPropertyInfo().getMls());
            property.setMlsId(realtorCom.getPropertyInfo().getMlsId());
            property.setStatus(realtorCom.getPropertyInfo().getStatus());
        }

        // Map address details
        if (realtorCom.getAddress() != null) {
            property.setFullStreetLine(
                    String.format("%s %s", realtorCom.getAddress().getStreet(), realtorCom.getAddress().getUnit())
            );
            property.setStreet(realtorCom.getAddress().getStreet());
            property.setUnit(realtorCom.getAddress().getUnit());
            property.setCity(realtorCom.getAddress().getCity());
            property.setState(realtorCom.getAddress().getState());
            property.setZipCode(realtorCom.getAddress().getZipCode());
        }

        // Map property description
        if (realtorCom.getDescription() != null) {
            property.setStyle(realtorCom.getDescription().getStyle());
            property.setBeds(realtorCom.getDescription().getBeds());
            property.setFullBaths(realtorCom.getDescription().getFullBaths());
            property.setHalfBaths(realtorCom.getDescription().getHalfBaths());
            property.setSqft(realtorCom.getDescription().getSqft());
            property.setYearBuilt(realtorCom.getDescription().getYearBuilt());
            property.setStories(realtorCom.getDescription().getStories());
            property.setLotSqft(realtorCom.getDescription().getLotSqft());
            property.setText(realtorCom.getDescription().getText());
            property.setAltPhotos(realtorCom.getDescription().getAltPhotos());
        }

        // Map listing details
        if (realtorCom.getListingDetails() != null) {
            property.setDaysOnMls(realtorCom.getListingDetails().getDaysOnMls());
            property.setListPrice(realtorCom.getListingDetails().getListPrice());
            property.setListPriceMin(realtorCom.getListingDetails().getListPriceMin());
            property.setListPriceMax(realtorCom.getListingDetails().getListPriceMax());
            property.setListDate(realtorCom.getListingDetails().getListDate());
            property.setSoldPrice(realtorCom.getListingDetails().getSoldPrice());
            property.setLastSoldDate(realtorCom.getListingDetails().getLastSoldDate());
            property.setPricePerSqft(realtorCom.getListingDetails().getPricePerSqft());
            property.setHoaFee(realtorCom.getListingDetails().getHoaFee());
            property.setNewConstruction(realtorCom.getListingDetails().getNewConstruction());
        }

        // Map location
        if (realtorCom.getLocation() != null) {
            property.setLatitude(realtorCom.getLocation().getLatitude());
            property.setLongitude(realtorCom.getLocation().getLongitude());
            property.setNeighborhoods(realtorCom.getLocation().getNeighborhoods());
            property.setCounty(realtorCom.getLocation().getCounty());
            property.setFipsCode(realtorCom.getLocation().getFipsCode());
        }

        // Map agent info
        if (realtorCom.getAgentInfo() != null) {
            property.setAgentId(realtorCom.getAgentInfo().getAgentId());
            property.setAgentName(realtorCom.getAgentInfo().getAgentName());
            property.setAgentEmail(realtorCom.getAgentInfo().getAgentEmail());
            property.setAgentPhones(
                    realtorCom.getAgentInfo().getAgentPhones() != null ?
                            realtorCom.getAgentInfo().getAgentPhones().toString() : null
            );
            property.setAgentMlsSet(realtorCom.getAgentInfo().getAgentMlsSet());
            property.setAgentNrdsId(realtorCom.getAgentInfo().getAgentNrdsId());
        }

        // Map broker info
        if (realtorCom.getBrokerInfo() != null) {
            property.setBrokerId(realtorCom.getBrokerInfo().getBrokerId());
            property.setBrokerName(realtorCom.getBrokerInfo().getBrokerName());
        }

        // Additional mappings if necessary...

        return property;
    }
}