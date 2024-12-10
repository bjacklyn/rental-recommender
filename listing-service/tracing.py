from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.sdk.resources import Resource as OpenTelemetryResource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from fastapi import FastAPI

def configure_tracer(app: FastAPI):
    otlp_exporter = OTLPSpanExporter(
        endpoint='3.15.232.29:4317',
        insecure=True,  
    )

    resource = OpenTelemetryResource(attributes={
        "service.name": "listing-service"
    })

    trace.set_tracer_provider(
        TracerProvider(resource=resource)
    )

    tracer_provider = trace.get_tracer_provider()
    tracer_provider.add_span_processor(BatchSpanProcessor(otlp_exporter))

    FastAPIInstrumentor.instrument_app(app)

    RequestsInstrumentor().instrument()