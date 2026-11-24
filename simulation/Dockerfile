FROM ubuntu:24.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends curl gnupg ca-certificates \
     && curl -fsSL https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
     && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(. /etc/os-release && echo $VERSION_CODENAME) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
     && apt-get update \
     && apt-get install -y --no-install-recommends gz-harmonic \
     && rm -rf /var/lib/apt/lists/*

FROM base AS sim

ENV GZ_SIM_RESOURCE_PATH=/simulation/gazebo/worlds:${GZ_SIM_RESOURCE_PATH}

WORKDIR /simulation

ENTRYPOINT ["gz", "sim", "-r", "-s", "-v", "4", "--headless-rendering"]
CMD ["camera.sdf"]
