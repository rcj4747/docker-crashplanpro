# CrashPlan Container with CrashPlan Desktop App


To run this container, please use this command:


    docker run -d --name="CrashPlan" \
           --net="bridge" \
           -p 4242:4242 \
           -p 4243:4243 \
           -p 4280:4280 \
           -v "/path/to/your/crashplan/config":"/config":rw \
           -v "/path/to/your/manifest/dir":"/backup":rw \
           -v "/volume1":"/volume1":rw \
               rcj4747/crashplanpro

###Some supported variables:

####Variable TZ: 

This will set the correct timezone. Set yours to avoid time related issues.

```
-e TZ="America/Sao_Paulo"
```

####Variable VNC_PASSWD:

This will enable password protection for your webui interface.

```
-e VNC_PASSWD="your_password"
```


###Ports:

####Port 4242 (TCP_PORT_4242): 

This port is used by CrashPlan for computer-to-computer backups.

```-p 4242:4242```

####Port 4243 (TCP_PORT_4243): 

This port is used by CrashPlan app to connect to CrashPlan service.

```-p 4243:4243```

####Port 4280 (TCP_PORT_4280):

This port exposes a noVNC instance with the CrashPlan Desktop App. 

```-p 4280:4280```

Then navigate to ```http://localhost:4280/vnc.html?autoconnect=true&host=0.0.0.0&port=4280``` to access the graphic user interface.
