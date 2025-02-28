# Use an arm64 Debian Bookworm base image
FROM arm64v8/debian:bookworm

# Add Raspberry Pi repository for Hailo packages
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    python3 \
    python3-pip

# Add Raspberry Pi repository and key
RUN wget -qO- http://archive.raspberrypi.com/debian/raspberrypi.gpg.key | apt-key add -
RUN echo "deb http://archive.raspberrypi.com/debian/ bookworm main" > /etc/apt/sources.list.d/raspi.list

# Install Hailo packages and dependencies
RUN apt-get update && apt-get install -y \
    hailo-all \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# Copy the folder "my_folder" to /app inside the container
COPY vehicleCounting /vehicleCounting

# Install required Python packages
RUN pip3 install --no-cache-dir --break-system-packages \
    Flask \
    opencv-python \
    psutil \
    pytz \
    mysql-connector-python \
    paho-mqtt

    # docker run -it --device /dev/hailo0 testing:1.1 /bin/bash