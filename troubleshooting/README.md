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

To use, make sure to use docker run specifying the nett, pid, and ipc namespaces of the container you want to troubleshoot
```bash
docker run --it -netd=container:<container-id> -pid=container:<container-id> --ipc=container:<container-id> bccourt/testing:tshoot
```

Docker run does not allow placing coniners in the same Mount namespace, but if we run in the same ipc namespace, we can share files placed in /dev/shm as a dirty workaround. Might be helpful to copy application logs or metrics from container A to the tshoot container, since container A doesn't have any troubleshooting or parsing tools installed.
