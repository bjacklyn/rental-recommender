from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.sdk.resources import Resource as OpenTelemetryResource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from fastapi import FastAPI

def configure_tracer(app: FastAPI):
    # Configure the OTLP exporter
    otlp_exporter = OTLPSpanExporter(
        endpoint='jaeger.tracing:4317',  # Adjust the endpoint to your Jaeger setup
        insecure=True,  # Use `True` if your Jaeger instance doesn't use TLS
    )

    resource = OpenTelemetryResource(attributes={
        "service.name": "chat-app"
    })

    # Set up trace provider with the OTLP exporter
    trace.set_tracer_provider(
        TracerProvider(resource=resource)
    )

    tracer_provider = trace.get_tracer_provider()
    tracer_provider.add_span_processor(BatchSpanProcessor(otlp_exporter))

    # Instrument FastAPI with OpenTelemetry
    FastAPIInstrumentor.instrument_app(app)

    # Instrument HTTP requests for outgoing traces
    RequestsInstrumentor().instrument()
