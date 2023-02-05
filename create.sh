#!/bin/bash

set -e # Exit on errors

echo "Creating services"

for service in 7001 7002 7003 7004 7005 7006 7007 7008 7009 7010 7011 7012; do

  echo "Creating service $service"

  sudo cp $service/$service.service /etc/systemd/system/$service.service

done

echo "Reloading systemctl"

sudo systemctl daemon-reload

echo "Services created"
