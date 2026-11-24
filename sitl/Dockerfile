FROM ubuntu:24.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

FROM base AS sitl

ARG PX4_BRANCH_NAME

WORKDIR /sitl/source
RUN git clone -b $PX4_BRANCH_NAME --depth 1 --single-branch https://github.com/PX4/PX4-Autopilot.git --recursive

ENV RUNS_IN_DOCKER=true
WORKDIR /sitl/source/PX4-Autopilot
RUN ./Tools/setup/ubuntu.sh

ENTRYPOINT ["make", "px4_sitl", "gz_x500"]