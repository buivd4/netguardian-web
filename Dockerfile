# syntax=docker/dockerfile:1
FROM ubuntu:18.04

ARG BASE_DIR=/var/www
ARG WEBSITE_NAME=base_site
ENV WEBSITE_NAME=${WEBSITE_NAME}

# Add apache2, mod_wsgi, python3.6 libraries
RUN apt-get update && apt-get install -y apache2 \
    libapache2-mod-wsgi-py3 \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3.6-dev \
    python3.6 \
    python3.6-venv \
    python3-pip \
    vim \
    sudo \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Expose port 80 on the container
EXPOSE 80

RUN mkdir ${BASE_DIR}/base_site
COPY netguardian_web ${BASE_DIR}/base_site
COPY deploy/django_apache.conf /etc/apache2/sites-available/000-default.conf
COPY deploy/startup.sh ${BASE_DIR}
COPY requirements.txt ${BASE_DIR}/base_site
ENTRYPOINT ["/bin/bash", "/var/www/startup.sh", "server"]