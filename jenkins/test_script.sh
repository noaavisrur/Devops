#!/bin/bash

# Find the process ID (PID) of the Flask process
pid=$(pgrep -f "flask run")

if [[ -z $pid ]]; then
    echo "Flask process not found."
else
    # Terminate the Flask process
    echo "Stopping Flask process with PID $pid..."
    kill $pid
    echo "Flask process stopped."
fi
This script uses pgrep to find the PID of the Flask process based on the process name (flask run). If the PID is found, it terminates the process using the kill command. If the Flask process is not found, it prints a message indicating that the process was not found.

Please ensure that you have the necessary permissions to execute the kill command and terminate processes.

# Define the port to check
port=5000

# Check if the port is open
if nc -z localhost $port >/dev/null; then
    echo "Port $port is open."
    exit 0
else
    echo "Port $port is not open."
    exit 1
fi

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
