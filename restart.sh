#!/bin/bash

set -e # Exit on errors

echo "Restarting services"

for service in 7001 7002 7003 7004 7005 7006 7007 7008 7009 7010 7011 7012; do
  echo "Restarting service $service"

  # Start the service
  systemctl restart redis_node_$service.service
done

echo "Services Restarted"
