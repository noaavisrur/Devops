#!/bin/bash

# Define the port to check
port=5000

# Check if the port is available
f lsof -Pi :$port -sTCP:LISTEN -t >/dev/null; then
    echo "Port $port is already in use by another process."
    exit 1
else
    echo "Port $port is available."
    exit 0
f

# Start Flask server in the background
cd /home/ec2-user/testing/flask/flask-app
flask run --host=0.0.0.0 &
sleep 5  # Wait for server to start

# Make HTTP request to Flask server and capture response
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$port)

# Print response
echo "HTTP response code: ${response}"

# Check if response code indicates success or failure
if [ "${response}" == "200" ]; then
    echo "Flask directory test passed!"
else
    echo "Flask directory test failed!"
    exit 1  # Exit with non-zero status to indicate failure
fi
