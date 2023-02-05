#!/bin/bash

set -e # Exit on errors

echo "Stopping services"

for service in 7001 7002 7003 7004 7005 7006 7007 7008 7009 7010 7011 7012; do

    echo "Stopping service $service"

    # Stop the service
    systemctl stop redis_node_$service.service

    # Disable the service on boot
    systemctl disable redis_node_$service.service

done

echo "Reloading systemctl"

sudo systemctl daemon-reload

echo "Services stopped"
