package com.rentalrecommender.dataprocessor.common;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Wrapper for Kafka messages, including trace context and payload.
 */
@Data
@NoArgsConstructor
public class KafkaMessage<T> {

    private TraceContext traceContext;
    private T payload;

    /**
     * Constructor for KafkaMessage.
     *
     * @param traceContext The trace metadata.
     * @param payload      The actual payload.
     */
    public KafkaMessage(TraceContext traceContext, T payload) {
        this.traceContext = traceContext;
        this.payload = payload;
    }
}
