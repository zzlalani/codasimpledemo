#!/bin/bash
echo "Stopping Echo Service instances..."

# Method 1: Find and kill processes by port
for port in 8080 8081 8082 8089; do
  pid=$(lsof -ti:$port)
  if [ -n "$pid" ]; then
    echo "Stopping process on port $port (PID: $pid)"
    kill $pid
  else
    echo "No process found running on port $port"
  fi
done

# Method 2 (alternative): Find by java process with specific jar file
# ps aux | grep "echo-service.*\.jar" | grep -v grep | awk '{print $2}' | xargs -r kill

echo "All Echo Service instances have been stopped."
