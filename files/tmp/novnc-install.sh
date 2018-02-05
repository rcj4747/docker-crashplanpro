#!/bin/bash

# Install noVNC
mkdir /opt/novnc
curl -L https://github.com/novnc/noVNC/archive/stable/v0.6.tar.gz | \
    tar --extract --gzip --strip=1 --directory=/opt/novnc

mkdir -p /opt/novnc/utils/websockify
curl -L https://github.com/novnc/websockify/archive/v0.8.0.tar.gz | \
    tar --extract --gzip --strip=1 --directory=/opt/novnc/utils/websockify
