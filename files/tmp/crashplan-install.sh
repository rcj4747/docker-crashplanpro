#!/bin/bash

# Install Crashplan
TARGETDIR=/usr/local/crashplan
BINSDIR="/usr/local/bin"
MANIFESTDIR=/backup
INITDIR=/etc/init.d
RUNLVLDIR=/etc/rc2.d

# Downloading Crashplan
mkdir /tmp/crashplan
curl -L "https://web-lbm-msp.crashplanpro.com/client/installers/CrashPlanPRO_${CP_VERSION}_Linux.tgz" | \
    tar --extract --gzip --strip=1 --directory=/tmp/crashplan
# curl -L http://192.168.0.100:88/CrashPlan_${CP_VERSION}_Linux.tgz | tar -xz --strip=1 -C /tmp/crashplan

pushd /tmp/crashplan

# Set defaults (These should cover all values requested by install.sh
# within the "INTERIVEW" section)
cat >> install.vars <<EOF
TARGETDIR=${TARGETDIR}
BINSDIR=${BINSDIR}
MANIFESTDIR=${MANIFESTDIR}
INITDIR=${INITDIR}
RUNLVLDIR=${RUNLVLDIR}
EOF
# echo "JRE_X64_DOWNLOAD_URL=http://192.168.0.100:88/jre-linux-x64-1.8.0_72.tgz" >> install.vars

# Creating directories
mkdir -p /usr/local/crashplan/bin /backup
mkdir -p ${TARGETDIR}
mkdir -p ${BINSDIR}
mkdir -p ${MANIFESTDIR}

# CACHEDIR in etc/my_init.d/01_config.sh is the 'cachePath' in my.service.xml
CACHEDIR=/config/cache
mkdir -p ${CACHEDIR}

# Skip inverview and read in our defaults
# $SCRIPT_DIR is defined in install.sh and is not meant to be expanded here
sed -i -e '/INTERVIEW=0/a source \"${SCRIPT_DIR}/install.vars\"' \
       -e 's/INTERVIEW=0/INTERVIEW=1/g' install.sh

# Install
yes "" | ./install.sh

# Remove installation files
popd
rm -rf /tmp/crashplan

# Add service to init
cat <<'EOT' > ${INITDIR}/crashplan
#!/bin/bash
source /opt/default-values.sh
case "$1" in
  start)
    /usr/bin/sv start crashplan
    /usr/bin/sv start openbox
    ;;
  stop)
    /usr/bin/sv stop crashplan
    /usr/bin/sv stop openbox
    ;;
  restart)
    /usr/bin/sv restart crashplan
    /usr/bin/sv restart openbox
    ;;
  status)
    eval 'exec 6<>/dev/tcp/127.0.0.1/${SERVICE_PORT} && echo "running" || echo "stopped"' 2>/dev/null
    exec 6>&- # close output connection
    exec 6<&- # close input connection
    ;;
esac
EOT
chmod +x /etc/init.d/crashplan
