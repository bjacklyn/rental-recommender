package com.rentalrecommender.dataprocessor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rentalrecommender.dataprocessor.common.KafkaMessage;
import com.rentalrecommender.dataprocessor.config.KafkaConfig;
import com.rentalrecommender.dataprocessor.model.RealtorCom;
import com.rentalrecommender.dataprocessor.source.RealtorComKafkaSource;
import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.sink.SinkFunction;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class RealtorComKafkaSourceIntegrationTest {

    private static final String TOPIC = "realtorcom";
    private static final String BOOTSTRAP_SERVERS = KafkaConfig.BOOTSTRAP_SERVERS; // Adjust based on your Kafka setup
    private static final ObjectMapper objectMapper = new ObjectMapper();
    private static final List<KafkaMessage<RealtorCom>> results = new ArrayList<>();
    private static KafkaProducer<String, String> producer;

    @BeforeAll
    static void setupKafkaProducer() {
        // Set up Kafka producer properties
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, BOOTSTRAP_SERVERS);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        producer = new KafkaProducer<>(props);
    }

    @Test
    public void testKafkaSourceWithSingleMessage() throws Exception {
        // Produce a single message to Kafka
        RealtorCom.PropertyInfo propertyInfo = new RealtorCom.PropertyInfo();
        propertyInfo.setPropertyId("12345");
        propertyInfo.setPropertyUrl("/property/12345");

        RealtorCom.Address address = new RealtorCom.Address();
        address.setStreet("123 Main St");
        address.setCity("Springfield");
        address.setState("IL");
        address.setZipCode("62701");

        RealtorCom realtorCom = new RealtorCom();
        realtorCom.setPropertyInfo(propertyInfo);
        realtorCom.setAddress(address);

        KafkaMessage<RealtorCom> kafkaMessage = new KafkaMessage<>();
        kafkaMessage.setTraceContext(null);
        kafkaMessage.setPayload(realtorCom);

        String jsonMessage = objectMapper.writeValueAsString(kafkaMessage);
        producer.send(new ProducerRecord<>(TOPIC, "key", jsonMessage));
        producer.flush();

        // Set up Flink environment
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        // Consume the Kafka topic and collect the output
        DataStream<KafkaMessage<RealtorCom>> sourceStream = RealtorComKafkaSource.createSource(env);
        sourceStream.addSink(new SinkFunction<>() {
            @Override
            public synchronized void invoke(KafkaMessage<RealtorCom> value, Context context) {
                KafkaMessage<RealtorCom> resultMessage = value;
                assertEquals("12345", resultMessage.getPayload().getPropertyInfo().getPropertyId());
                assertEquals("123 Main St", resultMessage.getPayload().getAddress().getStreet());
            }
        });

        // Execute the Flink job


    }
}
