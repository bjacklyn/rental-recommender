from kafka import KafkaProducer
import json
from datetime import datetime
from homeharvest import scrape_property

KAFKA_BROKER = 'localhost:9092'
KAFKA_TOPIC = 'realtorcom'

properties = scrape_property(
    location="CA",
    listing_type="for_rent",
    property_type=['single_family', 'multi_family'],
    past_days=1,
)

properties_json = properties.to_dict(orient='records')  

producer = KafkaProducer(
    bootstrap_servers=KAFKA_BROKER,
    value_serializer=lambda v: json.dumps(v).encode('utf-8')  
)

for message in properties_json:
    producer.send(KAFKA_TOPIC, value=message)
    print(f"Sent to Kafka: {message}")

producer.flush()
producer.close()
print("All messages sent to Kafka.")
