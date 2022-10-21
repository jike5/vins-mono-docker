# checking if you have nvidia
if [[ ~$(nvidia-smi | grep Driver) ]] 2>/dev/null; then
  echo "******************************"
  echo """It looks like you don't have nvidia drivers running. Consider running build_container_cpu.sh instead."""
  echo "******************************"
  while true; do
    read -p "Do you still wish to continue?" yn
    case $yn in
      [Yy]* ) make install; break;;
      [Nn]* ) exit;;
      * ) echo "Please answer yes or no.";;
    esac
  done
fi 

# UI permisions
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:docker

# docker pull jike5/vins-mono:cpu

# Remove existing container
docker rm -f vins &>/dev/null
sudo rm -rf vins_ws && mkdir -p vins_ws/src

# Create a new container
docker run -td --privileged --net=host --ipc=host \
    --name="vins" \
    -e "DISPLAY=$DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -e "XAUTHORITY=$XAUTH" \
    -e ROS_IP=127.0.0.1 \
    --cap-add=SYS_PTRACE \
    -v `pwd`/Datasets:/Datasets \
    -v /etc/group:/etc/group:ro \
    -v `pwd`/vins_ws:/vins_ws \
    jike5/vins-mono:cpu bash

# Git pull vins-mono and compile
docker exec -it vins bash -i -c "cd /vins_ws/src && git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git && cd .. && catkin_make"

