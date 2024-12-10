package com.rentalrecommender.dataprocessor.source;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rentalrecommender.dataprocessor.common.KafkaMessage;
import com.rentalrecommender.dataprocessor.config.KafkaConfig;
import com.rentalrecommender.dataprocessor.model.RealtorCom;
import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.serialization.DeserializationSchema;
import org.apache.flink.api.common.typeinfo.TypeHint;
import org.apache.flink.api.common.typeinfo.TypeInformation;
import org.apache.flink.connector.kafka.source.KafkaSource;
import org.apache.flink.connector.kafka.source.enumerator.initializer.OffsetsInitializer;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

import java.io.IOException;

public class RealtorComKafkaSource {

    private static final String TOPIC = "realtorcom"; 
    private static final String GROUP_ID = "realtorcom"; 

    public static DataStream<KafkaMessage<RealtorCom>> createSource(StreamExecutionEnvironment env) {
        KafkaSource<KafkaMessage<RealtorCom>> kafkaSource = KafkaSource.<KafkaMessage<RealtorCom>>builder()
                .setBootstrapServers(KafkaConfig.BOOTSTRAP_SERVERS)
                .setTopics(TOPIC)
                .setGroupId(GROUP_ID)
                .setStartingOffsets(OffsetsInitializer.earliest())
                .setValueOnlyDeserializer(new KafkaMessageDeserializationSchema())
                .build();
        return env.fromSource(kafkaSource, WatermarkStrategy.noWatermarks(), "RealtorCom Kafka Source");
    }

    public static class KafkaMessageDeserializationSchema implements DeserializationSchema<KafkaMessage<RealtorCom>> {
        private final ObjectMapper objectMapper = new ObjectMapper()
                .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        @Override
        public KafkaMessage<RealtorCom> deserialize(byte[] message) throws IOException {
            return objectMapper.readValue(message, objectMapper.getTypeFactory()
                    .constructParametricType(KafkaMessage.class, RealtorCom.class));
        }

        @Override
        public boolean isEndOfStream(KafkaMessage<RealtorCom> nextElement) {
            return false;
        }

        @Override
        public TypeInformation<KafkaMessage<RealtorCom>> getProducedType() {
            return TypeInformation.of(new TypeHint<KafkaMessage<RealtorCom>>() {});
        }
    }
}
