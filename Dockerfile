FROM python:3.10.8-slim-buster

# Update and install system packages
RUN apt update && apt upgrade -y && apt install -y git

# Copy requirements and install dependencies
COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -U pip && pip3 install -r /requirements.txt

# Set working directory and copy all files
WORKDIR /ben-url-filter-bot
COPY . /ben-url-filter-bot/

# Make start.sh executable
RUN chmod +x start.sh

# Start gunicorn and the bot
CMD ["/bin/bash", "start.sh"]
