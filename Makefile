# Variables
APP_NAME = codasimpledemo
NETWORK_NAME = echo-network

# Build the application with Maven
build:
	./mvnw clean package

# Run tests
test:
	./mvnw test

# Create Docker network if it doesn't exist
create-network:
	docker network inspect $(NETWORK_NAME) >/dev/null 2>&1 || docker network create $(NETWORK_NAME)

# Build Docker image
docker-build:
	docker build -t $(APP_NAME) .

# Run Docker containers
docker-up: create-network
	docker-compose up -d

# Stop Docker containers
docker-down:
	docker-compose down

# Run the original multi-instance script
run-multi-instance:
	chmod +x run-multi-instance.sh
	./run-multi-instance.sh

# Stop instances started by the script
stop-instances:
	chmod +x stop-instances.sh
	./stop-instances.sh

# Test endpoints (using curl)
test-endpoints: create-test-scripts
	./test-echo-api.sh

# Create test scripts for testing the echo API
create-test-scripts:
	@echo '#!/bin/bash' > test-echo-api.sh
	@echo 'echo "Testing Echo API endpoints..."' >> test-echo-api.sh
	@echo 'for port in 8080 8081 8082 8089; do' >> test-echo-api.sh
	@echo '  echo "Testing Echo API on port $${port}..."' >> test-echo-api.sh
	@echo '  curl -s -X POST -H "Content-Type: application/json" -d '"'"'{"game":"Mobile Legends", "gamerID":"GYUTDTE", "points":20}'"'"' http://localhost:$${port}/api/echo' >> test-echo-api.sh
	@echo '  echo -e "\n"' >> test-echo-api.sh
	@echo 'done' >> test-echo-api.sh
	@chmod +x test-echo-api.sh

# Clean build artifacts
clean:
	./mvnw clean
	rm -f test-echo-api.sh

# All-in-one command to set up and run demo
demo: build docker-build docker-up test-endpoints

.PHONY: build test docker-build docker-up docker-down run-multi-instance stop-instances test-endpoints create-test-scripts clean demo create-network
