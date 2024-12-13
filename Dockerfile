# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/sdk
ENV PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip \
    openjdk-11-jdk \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    && apt-get clean

# Install Android SDK command line tools
RUN mkdir -p $ANDROID_HOME && \
    curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && \
    unzip sdk-tools.zip -d $ANDROID_HOME && \
    rm sdk-tools.zip

# Accept Android licenses and install build tools
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;25.2.9519653" "cmake;3.18.1"

# Install TensorFlow Lite dependencies
RUN python3 -m pip install --upgrade pip && \
    pip install tensorflow

# Clone TensorFlow repository and set up workspace
RUN git clone --depth 1 https://github.com/tensorflow/tensorflow.git /tensorflow && \
    cd /tensorflow && \
    ./configure

# Set the working directory for your project
WORKDIR /app

# Define default command (you can override this)
CMD ["/bin/bash"]
