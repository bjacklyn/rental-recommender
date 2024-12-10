package com.rentalrecommender.dataprocessor;

import com.rentalrecommender.dataprocessor.model.Property;
import com.rentalrecommender.dataprocessor.model.RealtorCom;
import com.rentalrecommender.dataprocessor.transformer.RealtorComToPropertyTransformer;
import org.apache.flink.runtime.testutils.MiniClusterResourceConfiguration;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.test.util.MiniClusterWithClientResource;
import org.junit.ClassRule;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class RealtorComToPropertyTransformerIntegrationTest {

    @ClassRule
    public static final MiniClusterWithClientResource flinkCluster =
            new MiniClusterWithClientResource(new MiniClusterResourceConfiguration.Builder()
                    .setNumberSlotsPerTaskManager(2)
                    .setNumberTaskManagers(1)
                    .build());

    @Test
    public void testRealtorComToPropertyPipeline() throws Exception {
        final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        RealtorCom sampleInput = new RealtorCom();
        RealtorCom.PropertyInfo propertyInfo = new RealtorCom.PropertyInfo();
        propertyInfo.setPropertyId("12345");
        propertyInfo.setPropertyUrl("http://example.com/property/12345");
        sampleInput.setPropertyInfo(propertyInfo);

        RealtorCom.Description description = new RealtorCom.Description();
        description.setBeds(3);
        description.setFullBaths(2);
        sampleInput.setDescription(description);

        List<RealtorCom> inputList = new ArrayList<>();
        inputList.add(sampleInput);

        DataStream<RealtorCom> inputStream = env.fromCollection(inputList);

        RealtorComToPropertyTransformer transformer = new RealtorComToPropertyTransformer();
        DataStream<Property> propertyStream = inputStream.map(transformer::transform);

        List<Property> resultList = new ArrayList<>();
        propertyStream.executeAndCollect().forEachRemaining(resultList::add);

        assertEquals(1, resultList.size());
        Property result = resultList.get(0);
        assertEquals("12345", result.getPropertyId());
        assertEquals("http://example.com/property/12345", result.getPropertyUrl());
        assertEquals(3, (int) result.getBeds());
        assertEquals(2, (int) result.getFullBaths());

        System.out.println("Test Output: " + result);
    }
}