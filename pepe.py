import sys
sys.path.append("/usr/lib/python3/dist-packages")
import hailo_platform
print(hailo_platform.__file__)  # Just to check if it's accessible
import importlib

def check_library(lib_name):
    try:
        importlib.import_module(lib_name)
        print(f"✅ {lib_name} is installed and accessible.")
    except ImportError:
        print(f"❌ {lib_name} is NOT installed or not accessible.")

# List of required libraries
libraries = [
    "hailo_platform",
    "flask",
    "cv2",
    "psutil",
    "pytz",
    "mysql.connector",
    "paho.mqtt.client"
]

# Check each library
for lib in libraries:
    check_library(lib)
