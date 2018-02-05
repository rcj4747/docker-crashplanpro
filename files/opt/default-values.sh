# Load default values if empty
VNC_PORT=4239
WEB_PORT=4280
BACKUP_PORT=4242
SERVICE_PORT=4243
VNC_CREDENTIALS=/nobody/.vnc_passwd

APP_NAME="CrashPlan ${CP_VERSION}"

if [[ -n $VNC_PASSWD ]]; then
  VNC_SECURITY="SecurityTypes TLSVnc,VncAuth -PasswordFile ${VNC_CREDENTIALS}"
else
  VNC_SECURITY="SecurityTypes None"
fi
