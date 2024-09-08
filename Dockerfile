# Use an appropriate base image
FROM ubuntu:20.04

# Set environment variables
ENV GAME_DIR=/opt/voxel_turf
ENV STEAMCMD_DIR=/opt/steamcmd

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    jq \
    curl \
    tar \
    unzip \
    libsdl2-2.0-0 \
    libsdl2-net-2.0-0 \
    lib32gcc1 \
    && apt-get clean

# Install yq
RUN wget https://github.com/mikefarah/yq/releases/download/v4.20.2/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq



# Create directories for SteamCMD and Voxel Turf
RUN mkdir -p $STEAMCMD_DIR $GAME_DIR

# Install SteamCMD
WORKDIR $STEAMCMD_DIR
RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz





# Install Voxel Turf using SteamCMD
RUN $STEAMCMD_DIR/steamcmd.sh +login anonymous +force_install_dir $GAME_DIR +app_update 526340 validate +quit

# Create necessary directories for mods
RUN mkdir -p $GAME_DIR/workshop

# Expose the necessary ports
EXPOSE 5728/udp

# Set the entrypoint to start the server
ENTRYPOINT ["/usr/local/bin/configuration/start-server.sh"]
