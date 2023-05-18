#!/bin/bash

set -e # Exit on errors

echo "Restarting service"

for service in 6379; do
  echo "Restarting service $service"

  # Start the service
  systemctl restart redis_service_$service.service
done

echo "Services Restarted"
