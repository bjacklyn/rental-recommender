package com.rentalrecommender.common;

import org.apache.flink.metrics.Counter;
import org.apache.flink.metrics.Meter;
import org.apache.flink.metrics.MetricGroup;

public class MetricsUtils {

    public static Counter registerCounter(MetricGroup metricGroup, String name) {
        return metricGroup.counter(name);
    }

    public static Meter registerMeter(MetricGroup metricGroup, String name, int timeSpanSeconds) {
        return metricGroup.meter(name, new org.apache.flink.metrics.MeterView(timeSpanSeconds));
    }
}