FROM phusion/baseimage:latest
MAINTAINER rcj4747

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV USER_ID="0" \
    GROUP_ID="0" \
    TERM="xterm" \
    CP_VERSION="4.9.0_1436674888490_33"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
ADD ./files /files
RUN sync && /bin/bash /files/tmp/install.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
# /data is for incoming backups
# /config is for client configuration
VOLUME /data /config
EXPOSE 4243 4242 4280
