# Use an official Python runtime as a parent image
FROM python:3.8

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Upgrade pip and setuptools
RUN python -m pip install --no-cache-dir --upgrade pip setuptools

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file into the container
COPY ./django_central-development/requirements.txt /app/

# Debugging: Display the contents of requirements.txt
RUN cat /app/requirements.txt

# Install any needed packages specified in requirements.txt
RUN python -m pip install --no-cache-dir -r requirements.txt

# Debugging: Display the contents of the /app directory
RUN ls -al /app

# Copy the current directory contents into the container at /app
COPY ./django_central-development /app/

# Expose port 8000 for the Django development server
EXPOSE 8000

# Run command to start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
