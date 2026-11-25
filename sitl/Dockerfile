FROM px4io/px4-dev:v1.18.0 AS build
ARG PX4_REVISION_TAG

WORKDIR /source
RUN git clone -b $PX4_REVISION_TAG --depth 1 https://github.com/PX4/PX4-Autopilot.git --recursive

RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list \
    && wget https://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
    && apt-get update \
    && apt-get install -y --no-install-recommends libgz-transport13-dev libgz-sim8-dev libgz-sensors8-dev libgz-plugin2-dev \
    libopencv-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-tools \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav default-jre libzmq3-dev cppzmq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /source/PX4-Autopilot
RUN make px4_sitl


FROM ubuntu:24.04 AS sitl

RUN apt-get update && apt-get install -y --no-install-recommends wget curl gnupg ca-certificates \
    && echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(. /etc/os-release && echo $VERSION_CODENAME) main" > /etc/apt/sources.list.d/gazebo-stable.list \
    && wget https://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
    && apt-get update  \
    && apt-get install -y --no-install-recommends ca-certificates libgz-transport13 gz-transport13-cli libgz-sim8 \
    libgz-sensors8 libgz-plugin2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /sitl/px4

COPY --from=build /source/PX4-Autopilot/build/px4_sitl_default/bin ./bin
COPY --from=build /source/PX4-Autopilot/build/px4_sitl_default/etc ./rootfs/etc

WORKDIR /sitl/px4/rootfs

ENTRYPOINT ["/sitl/px4/bin/px4", "/sitl/px4/rootfs"]