# Use a slim Python image
FROM python:3.11

# Install system packages needed for GObject introspection and GStreamer
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-gi \
    gir1.2-gstreamer-1.0 \
    gir1.2-glib-2.0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    libgstreamer-plugins-base1.0-dev \
    udev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY pepe.py .

# Set device permissions (for Hailo device)
RUN echo 'SUBSYSTEM=="misc", KERNEL=="hailo0", MODE="0666"' > /etc/udev/rules.d/99-hailo.rules

# Mount hailo_platform (handled via Docker volume at runtime)
VOLUME ["/usr/lib/python3/dist-packages/hailo_platform"]

# Set entrypoint to Hailo CLI
ENTRYPOINT ["/bin/bash"]


# docker run --rm -it \
#   --device=/dev/hailo0 \
#   -v /usr/lib/libhailort.so.4.20.0:/usr/lib/libhailort.so.4.20.0 \
#   -v /usr/lib/libhailort.so:/usr/lib/libhailort.so \
#   testing:1.2
# 