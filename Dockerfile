FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    wget \
    libgl1-mesa-glx \
    libglib2.0-dev \
    libcairo2-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
RUN mkdir /app

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' --shell /bin/bash user \
    && chown -R user:user /app

# All users can use /home/user as their home directory
ENV HOME=/home/user

# Clonse https://github.com/xpcapital/webui-api.git
RUN git clone https://github.com/xpcapital/webui-api.git /app

# Set the working directory to /app
WORKDIR /app

# Install dependencies
# RUN ./install.sh

CMD ["./webui.sh", "-f", "--api", "--nowebui", "--port", "8000", "--listen"]