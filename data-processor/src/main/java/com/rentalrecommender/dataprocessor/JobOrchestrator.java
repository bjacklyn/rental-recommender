package com.rentalrecommender.dataprocessor;

import com.rentalrecommender.dataprocessor.model.Property;
import com.rentalrecommender.dataprocessor.model.RealtorCom;
import com.rentalrecommender.dataprocessor.source.RealtorComKafkaSource;
import com.rentalrecommender.dataprocessor.sink.PropertyMongoDbSink;
import com.rentalrecommender.dataprocessor.transformer.RealtorComToPropertyTransformer;
import com.rentalrecommender.dataprocessor.config.TracingConfig;
import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

public class JobOrchestrator {

    public static void main(String[] args) throws Exception {
        TracingConfig.initTracing();

        // Get the global tracer
        Tracer tracer = GlobalOpenTelemetry.getTracer("RealtorCom-Job");

        // Set up the Flink execution environment
        final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.enableCheckpointing(5000); // 5000ms checkpoint interval

        // Create the Kafka source for RealtorCom messages
        DataStream<RealtorCom> realtorComStream = RealtorComKafkaSource.createSource(env)
                .map(kafkaMessage -> {
                    Span span = tracer.spanBuilder("Extract Payload").startSpan();
                    try (var scope = span.makeCurrent()) {
                        span.setAttribute("traceId", kafkaMessage.getTraceContext().getTraceId());
                        span.setAttribute("propertyId", kafkaMessage.getPayload().getPropertyInfo().getPropertyId());
                        return kafkaMessage.getPayload();
                    } finally {
                        span.end();
                    }
                }).name("Extract RealtorCom Payload");

        // Transform the RealtorCom objects into Property objects
        RealtorComToPropertyTransformer transformer = new RealtorComToPropertyTransformer();
        DataStream<Property> propertyStream = realtorComStream
                .map(realtorCom -> {
                    Span span = tracer.spanBuilder("Transform to Property").startSpan();
                    try (var scope = span.makeCurrent()) {
                        Property property = transformer.transform(realtorCom);
                        span.setAttribute("propertyId", property.getPropertyId());
                        return property;
                    } finally {
                        span.end();
                    }
                }).name("Transform RealtorCom to Property");

        // Write the Property objects to MongoDB
        propertyStream.addSink(new PropertyMongoDbSink())
                .name("MongoDB Sink");

        // Execute the Flink job
        env.execute("RealtorComToProperty");
    }
}