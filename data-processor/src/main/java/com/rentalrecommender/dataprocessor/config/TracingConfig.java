package com.rentalrecommender.dataprocessor.config;

import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.sdk.OpenTelemetrySdk;
import io.opentelemetry.sdk.trace.SdkTracerProvider;
import io.opentelemetry.sdk.trace.export.BatchSpanProcessor;
import io.opentelemetry.sdk.trace.export.SpanExporter;
import io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporter;

public class TracingConfig {
    private static final String OLTP_ENDPOINT = "http://localhost:4317";

    public static OpenTelemetry initTracing() {
        SpanExporter otlpExporter = OtlpGrpcSpanExporter.builder()
                .setEndpoint(OLTP_ENDPOINT)
                .build();

        SdkTracerProvider tracerProvider = SdkTracerProvider.builder()
                .addSpanProcessor(BatchSpanProcessor.builder(otlpExporter).build())
                .build();

        OpenTelemetrySdk openTelemetrySdk = OpenTelemetrySdk.builder()
                .setTracerProvider(tracerProvider)
                .build();
        GlobalOpenTelemetry.set(openTelemetrySdk);
        return openTelemetrySdk;
    }
}
