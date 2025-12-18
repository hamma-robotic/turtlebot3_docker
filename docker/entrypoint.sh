#!/bin/bash
set -e

echo " Sourcing ROS 2 Humble"
source /opt/ros/humble/setup.bash

echo " Sourcing TurtleBot3 workspace"
source /root/tb3_ws/install/setup.bash

export TURTLEBOT3_MODEL=${TURTLEBOT3_MODEL:-burger}
echo " TurtleBot3 model: $TURTLEBOT3_MODEL"

exec "$@"
