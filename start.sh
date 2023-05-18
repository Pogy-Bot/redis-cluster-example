#!/bin/bash

set -e # Exit on errors

echo "Starting service"

for service in 6379; do
  echo "Starting service $service"

  # Start the service
  systemctl start redis_service_$service.service
done

echo "Services started"
