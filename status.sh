#!/bin/bash

set -e # Exit on errors

echo "Checking status of services"

for service in 7001 7002 7003 7004 7005 7006 7007 7008 7009 7010 7011 7012; do
    echo "Status for $service"

    # Check the status of the service
    systemctl status redis_$service.service
done

echo "Done checking status of services"
