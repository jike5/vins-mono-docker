# UI permisions
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:docker

# docker pull jike5/vins-mono:cpu

# Remove existing container
docker rm -f vins &>/dev/null

# Create a new container
docker run -td --privileged --net=host --ipc=host \
    --name="vins" \
    -e "DISPLAY=$DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -e "XAUTHORITY=$XAUTH" \
    -e ROS_IP=127.0.0.1 \
    --cap-add=SYS_PTRACE \
    -v /media/zzx/Samsung_T5/6_dataset:/Datasets \
    -v /etc/group:/etc/group:ro \
    -v `pwd`/vins_ws:/vins_ws \
    -v `pwd`/vins_vo:/vins_vo \
    -v `pwd`/output:/output \
    jike5/vins-mono:cpu bash
