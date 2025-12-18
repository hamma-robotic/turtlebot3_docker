# TurtleBot3 ROS2 Humble Docker Simulation

This repository provides a working and verified TurtleBot3 simulation using ROS 2 Humble, Gazebo, RViz, and keyboard teleoperation inside Docker.

## Requirements
- Docker
- Linux (Ubuntu recommended)
- X11 display server

## Build the Docker image
```bash
docker build -t turtlebot3_humble .

#Allow Docker X11 access
xhost +local:docker
#Run the container
docker run -it --rm \
  -e TURTLEBOT3_MODEL=burger \
  --env DISPLAY=$DISPLAY \
  --env QT_X11_NO_MITSHM=1 \
  --env LIBGL_ALWAYS_SOFTWARE=1 \
  --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
  turtlebot3_humble
#Chose the wold you want to launch it 
ls /root/tb3_ws/src/turtlebot3_simulations/turtlebot3_gazebo/worlds

#Launch Gazebo or Launch another wold in this list
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py

#Launch RViz (New Terminal)

#Open a new terminal, enter the container again, then run:

ros2 launch turtlebot3_bringup rviz2.launch.py

#Teleoperate the robot
ros2 run turtlebot3_teleop teleop_keyboard
#Notes

#Robot may not be immediately visible due to Gazebo camera position.

#Use mouse wheel to zoom out or press R to reset camera.
