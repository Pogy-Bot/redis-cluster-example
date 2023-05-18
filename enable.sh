#!/bin/bash

set -e # Exit on errors

echo "Enabling services"

for service in 6379; do
    echo "Enabling service $service"

    systemctl enable /etc/systemd/system/redis_service_$service.service
done

echo "Reloading systemctl"

sudo systemctl daemon-reload

echo "Enabling finished"
