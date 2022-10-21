# Image taken from: https://github.com/turlucode/ros-docker-gui
FROM jike5/ros-melodic:cpu

ENV ROS_DISTRO melodic
      # set up thread number for building
RUN   if [ "x$(nproc)" = "x1" ] ; then export USE_PROC=1 ; \
      else export USE_PROC=$(($(nproc)/2)) ; fi && \
      apt-get update && apt-get install -y \
      cmake \
      libatlas-base-dev \
      libeigen3-dev \
      libgoogle-glog-dev \
      libsuitesparse-dev \
      python-catkin-tools \
      ros-${ROS_DISTRO}-cv-bridge \
      ros-${ROS_DISTRO}-image-transport \
      ros-${ROS_DISTRO}-message-filters \
      ros-${ROS_DISTRO}-tf && \
      rm -rf /var/lib/apt/lists/*

	  # Build and install Ceres
ENV CERES_VERSION="1.14.0"
#RUN   git clone https://ceres-solver.googlesource.com/ceres-solver && \
#      cd ceres-solver && \
#      git checkout tags/${CERES_VERSION} && \
#      mkdir build && cd build && \
#      cmake .. && \
#      make -j$(USE_PROC) install && \
#      rm -rf ../../ceres-solver

RUN wget ceres-solver.org/ceres-solver-1.14.0.tar.gz &&\
	tar xvf ceres-solver-1.14.0.tar.gz &&\
	cd ceres-solver-1.14.0 &&\
	mkdir build && cd build &&\
	cmake .. &&\
	make -j4 &&\
	make install
	

COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x  /ros_entrypoint.sh  
ENTRYPOINT ["/ros_entrypoint.sh"]

ENV TERM xterm
ENV PYTHONIOENCODING UTF-8
CMD ["bash"]
