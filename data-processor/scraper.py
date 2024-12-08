from kafka import KafkaProducer
import json
from datetime import datetime
from homeharvest import scrape_property

# Kafka configuration
KAFKA_BROKER = 'localhost:9092'
KAFKA_TOPIC = 'realtorcom'

# Fetch properties
properties = scrape_property(
    location="CA",
    listing_type="for_rent",
    property_type=['single_family', 'multi_family'],
    past_days=1,
)

print(f"Number of properties: {len(properties)}")

# Convert properties to JSON
properties_json = properties.to_dict(orient='records')  # Convert DataFrame to list of dictionaries

# Initialize Kafka producer
producer = KafkaProducer(
    bootstrap_servers=KAFKA_BROKER,
    value_serializer=lambda v: json.dumps(v).encode('utf-8')  # Serialize JSON as UTF-8
)

# Send data to Kafka topic
for message in properties_json:
    producer.send(KAFKA_TOPIC, value=message)
    print(f"Sent to Kafka: {message}")

producer.flush()  # Ensure all messages are sent
producer.close()
print("All messages sent to Kafka.")
