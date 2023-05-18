#!/bin/bash

set -e # Exit on errors

echo "Stopping service"

for service in 6379; do

    echo "Stopping service $service"

    # Stop the service
    systemctl stop redis_service_$service.service

    # Disable the service on boot
    systemctl disable redis_service_$service.service

done

echo "Reloading systemctl"

sudo systemctl daemon-reload

echo "Services stopped"
