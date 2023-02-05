#!/bin/bash

set -e # Exit on errors

echo "Enabling services"

for service in 7001 7002 7003 7004 7005 7006 7007 7008 7009 7010 7011 7012; do
    echo "Enabling service $service"

    systemctl enable /etc/systemd/system/redis_node_$service.service
done

echo "Reloading systemctl"

sudo systemctl daemon-reload

echo "Enabling finished"
