FROM python:3.10.8-slim-buster

# Install system dependencies
RUN apt update && apt upgrade -y && apt install -y git

# Copy requirements file first to leverage Docker caching
COPY requirements.txt /requirements.txt

# Ensure compatible Flask and Werkzeug versions to fix url_quote issue
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir Flask==2.0.3 Werkzeug==2.0.3 \
 && pip install --no-cache-dir -r /requirements.txt

# Set the working directory and copy project files
WORKDIR /ben-url-filter-bot
COPY . /ben-url-filter-bot/

# Ensure start.sh is executable
RUN chmod +x start.sh

# Start the app using bash script
CMD ["/bin/bash", "start.sh"]
