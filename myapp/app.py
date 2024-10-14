from flask import Flask, jsonify, render_template, Blueprint
from flask_restx import Api, Resource, Swagger
from flask_restx.apidoc import apidoc

import json
import logging
import os

from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import Resource as OpenTelemetryResource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.instrumentation.logging import LoggingInstrumentor

@apidoc.add_app_template_global
def swagger_static(filename):
    return "/myapp/swaggerui/{0}".format(filename)

app = Flask(__name__)
api = Api(app, doc='/swagger')

# Setup the swagger endpoints
@api.route('/custom-swagger.json')
class CustomSwaggerJson(Resource):
    def get(self):
        """Returns swagger.json with updated basePath"""
        swagger = Swagger(api)
        d = swagger.as_dict()
        d['basePath'] = '/myapp'
        return jsonify(d)

@api.documentation
def custom_ui():
    return render_template("swagger-ui.html", title=api.title, specs_url="/myapp/custom-swagger.json")

# Resource can be required for some backends, e.g. Jaeger
# If resource wouldn't be set - traces wouldn't appears in Jaeger
resource = OpenTelemetryResource(attributes={
    "service.name": "myapp"
})

# Set up OpenTelemetry tracing
trace.set_tracer_provider(TracerProvider(resource=resource))
tracer = trace.get_tracer(__name__)

# Configure the OTLP exporter
otlp_exporter = OTLPSpanExporter(
    endpoint='jaeger:4317',  # Adjust the endpoint to your Jaeger setup
    insecure=True,  # Use `True` if your Jaeger instance doesn't use TLS
)

# Set up a BatchSpanProcessor to export spans
span_processor = BatchSpanProcessor(otlp_exporter)
trace.get_tracer_provider().add_span_processor(span_processor)

# Instrument the Flask app
FlaskInstrumentor().instrument_app(app)

class JsonFormatter(logging.Formatter):
    def format(self, record):
        log_obj = {
            "timestamp": self.formatTime(record),
            "level": record.levelname,
            "message": record.getMessage(),
            "trace_id": record.trace_id,
            "span_id": record.span_id,
            "file": os.path.basename(record.pathname) + ":" + str(record.lineno),
        }
        return json.dumps(log_obj)

class TraceAwareLoggingHandler(logging.StreamHandler):
    def emit(self, record):
        span = trace.get_current_span()
        if span and span.get_span_context().is_valid:
            record.trace_id = span.get_span_context().trace_id
            record.span_id = span.get_span_context().span_id
        else:
            record.trace_id = None
            record.span_id = None
        super().emit(record)

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Create a stream handler with the JSON formatter
handler = TraceAwareLoggingHandler()
handler.setFormatter(JsonFormatter())

# Suppress default logging output
logging.getLogger().handlers.clear()

# Set our json handler as the global default
logging.getLogger().addHandler(handler)

@api.route('/api/hello')
class HelloWorld(Resource):
    def get(self):
        """Returns a hello world message"""
        with tracer.start_as_current_span("hello_world_trace"):
            logger.info("Starting trace for /api/hello endpoint. This msg will have the trace info embedded in it!")
            return jsonify({"message": "Hello, World!"})

if __name__ == '__main__':
    print(app.url_map)
    app.run(host='0.0.0.0', debug=True)
