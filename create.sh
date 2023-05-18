#!/bin/bash

set -e # Exit on errors

echo "Creating service"

for service in 6379; do

  echo "Creating service $service"

  sudo cp $service/$service.service /etc/systemd/system/redis_service_$service.service

done

echo "Reloading systemctl"

sudo systemctl daemon-reload

echo "Services created"
