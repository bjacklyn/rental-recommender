package com.rentalrecommender.dataprocessor.common;

import lombok.Data;

/**
 * Represents the trace context for distributed tracing.
 */
@Data
public class TraceContext {

    private String traceId;
    private String spanId;
    private String parentSpanId;
    private Boolean sampled;

    /**
     * Constructor for TraceContext.
     *
     * @param traceId       The unique identifier for the trace.
     * @param spanId        The unique identifier for the span.
     * @param parentSpanId  The parent span's identifier.
     * @param sampled       Indicates if the trace is sampled.
     */
    public TraceContext(String traceId, String spanId, String parentSpanId, Boolean sampled) {
        this.traceId = traceId;
        this.spanId = spanId;
        this.parentSpanId = parentSpanId;
        this.sampled = sampled;
    }
}