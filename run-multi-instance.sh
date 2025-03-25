#!/bin/bash

echo "Building the Demo Service..."
./mvnw clean package
# @todo change to parameterized,
echo "Starting three instances of the Demo Service on different ports..."

java -jar target/codasimpledemo-0.0.1-SNAPSHOT.jar --server.port=8080 > demo-service-8080.log 2>&1 &
echo "Started instance on port 8080"

java -jar target/codasimpledemo-0.0.1-SNAPSHOT.jar --server.port=8081 > demo-service-8081.log 2>&1 &
echo "Started instance on port 8081"

java -jar target/codasimpledemo-0.0.1-SNAPSHOT.jar --server.port=8082 > demo-service-8082.log 2>&1 &
echo "Started instance on port 8082"

echo "All instances started! Check logs in demo-service-*.log files"
