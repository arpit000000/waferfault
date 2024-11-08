# Use the official Python 3.8 slim image
FROM python:3.8-slim-buster

# Update system and install necessary dependencies
RUN apt-get update && apt-get install -y \
    openssl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Upgrade pip to the latest version and install pymongo
RUN pip install --upgrade pip
RUN pip install --upgrade pymongo

# Set the working directory
WORKDIR /app

# Copy your application code to the container
COPY . /app

# Install the dependencies from requirements.txt
RUN pip install -r requirements.txt

# Ensure correct permissions for app.py and entry point
RUN chmod +x app.py

# Set environment variable for SSL certificates if needed
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# Command to run your application
CMD ["python3", "app.py"]
