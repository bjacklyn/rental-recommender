package com.rentalrecommender.dataprocessor.common;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class KafkaMessage<T> {

    private TraceContext traceContext;
    private T payload;

    public KafkaMessage(TraceContext traceContext, T payload) {
        this.traceContext = traceContext;
        this.payload = payload;
    }
}
