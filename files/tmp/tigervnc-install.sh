#!/bin/bash

# Install TigerVNC (Drop on move to Ubuntu Artful of later for archive version)
curl -L https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | \
    tar --extract --gzip --strip=1 --directory=/

# vncpasswd.py
mkdir -p /opt/vncpasswd
curl -L https://github.com/trinitronx/vncpasswd.py/archive/v1.2.0.tar.gz | \
    tar --extract --gzip --strip=1 --directory=/opt/vncpasswd
