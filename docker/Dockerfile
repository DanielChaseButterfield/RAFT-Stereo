# Base image with CUDA 10.2 and cuDNN 8
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    sudo \
    ca-certificates \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    tmux \
    tmuxp \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm /tmp/miniconda.sh && \
    conda clean -afy

# Create non-root user
ARG USERNAME=dbutterfield3
ARG USER_UID=3332128
ARG USER_GID=2626

RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} && \
    usermod -aG sudo ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy environment file into container
COPY environment.yaml /tmp/environment.yaml

# Switch to non-root user
USER ${USERNAME}
WORKDIR /home/${USERNAME}
SHELL ["/bin/bash", "-c"]

# Initialize conda and create environment
RUN conda config --set always_yes true && \
    conda config --set channel_priority strict && \
    conda tos accept --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --channel https://repo.anaconda.com/pkgs/r && \
    conda env create -f /tmp/environment.yaml && \
    conda clean -afy

# Automatically activate the environment on shell start
RUN echo ". $CONDA_DIR/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate raftstereo" >> ~/.bashrc && \
    echo "set -g mouse on" > ~/.tmux.conf

# Start with bash shell
CMD ["/bin/bash"]
