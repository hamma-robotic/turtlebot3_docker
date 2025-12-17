# -------------------------------
FROM osrf/ros:humble-desktop-full

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools and dependencies
RUN apt-get update && apt-get install -y \
    git wget curl unzip python3-colcon-common-extensions \
    python3-rosdep python3-vcstool \
    ros-humble-dynamixel-sdk \
    ros-humble-gazebo-ros-pkgs ros-humble-gazebo-ros2-control \
    ros-humble-xacro \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init || true
RUN rosdep update

# Create workspace
RUN mkdir -p /root/tb3_ws/src
WORKDIR /root/tb3_ws/src

# Clone required TurtleBot3 repositories
RUN git clone --depth 1 -b humble https://github.com/ROBOTIS-GIT/turtlebot3.git
RUN git clone --depth 1 -b humble https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
RUN git clone --depth 1 -b humble https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

WORKDIR /root/tb3_ws

# Install workspace dependencies
RUN rosdep install --from-paths src --ignore-src -r -y || true

# Build workspace
RUN . /opt/ros/humble/setup.sh && \
    colcon build --symlink-install

# Environment setup
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
RUN echo "source /root/tb3_ws/install/setup.bash" >> /root/.bashrc
#RUN echo "export TURTLEBOT3_MODEL=burger" >> /root/.bashrc

# GUI display
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
VOLUME ["/tmp/.X11-unix:/tmp/.X11-unix:rw"]

CMD ["/bin/bash"]
