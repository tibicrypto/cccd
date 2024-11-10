# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the missing libGL.so.1 library
RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0 libgomp1 && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y build-essential gfortran libblas-dev liblapack-dev
# Make start.sh executable
RUN chmod +x /app/start.sh

# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip setuptools==57.5.0

RUN pip install --no-cache-dir -r requirements.txt

# Run start.sh when the container launches
CMD ["/app/start.sh"]