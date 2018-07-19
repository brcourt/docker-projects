This dockerfile builds an ubuntu image filled with troubleshooting tools.

Installed Packages:
* dnsutils
* telnet
* curl
* wget
* tar
* tcpdump
* procps
* iputils-ping
* net-tools

To use, make sure to use docker run specifying the net, pid, and ipc namespaces of the container you want to troubleshoot
```bash
docker run -it --net=container:<container-id> --pid=container:<container-id> --ipc=container:<container-id> bccourt/testing:tshoot
```

Running this container with the above command and specifying an nginx container with an ID of 903cd158b4d3. Note how we see both containers' processes in the `ps` output, `netstat` shows a listening process (which is not from tshoot), and running `curl` to localhost gets routed to the nginx container's localhost address.
```
[ec2-user@ip-172-31-7-147 /]$ docker run -it --net=container:903 --pid=container:903 --ipc=container:903 bccourt/testing:tshoot
root@TSHOOT-->903cd158b4d3:/$
root@TSHOOT-->903cd158b4d3:/$ ps -ef --forest
UID        PID  PPID  C STIME TTY          TIME CMD
root       568     0  0 20:29 pts/0    00:00:00 /bin/bash__tshoot-entrypoint
root       595   568  0 20:32 pts/0    00:00:00  \_ ps -ef --forest
root         1     0  0 Jul18 ?        00:00:00 nginx: master process nginx-debug -g daemon off;
104         43     1  0 Jul18 ?        00:00:00 nginx: worker process
root@TSHOOT-->903cd158b4d3:/$ netstat -ntpl
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      1/nginx: master pro
root@TSHOOT-->903cd158b4d3:/$ curl localhost
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
root@TSHOOT-->903cd158b4d3:/$
```

Docker run does not allow placing coniners in the same Mount namespace, but if we run in the same ipc namespace, we can share files placed in /dev/shm as a dirty workaround. Might be helpful to copy application logs or metrics from container A to the tshoot container, since container A doesn't have any troubleshooting or parsing tools installed.
