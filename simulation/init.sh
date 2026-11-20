#!/bin/bash

echo "Started Gazebo server initialization"
gz sim -r -s --headless-rendering camera_sensor.sdf &
echo "Gazebo server was initialized successfully!"

echo "Started Gazebo GUI initialization"
gz sim -g &
echo "Gazebo GUI was initialized successfully!"

exec "$@"