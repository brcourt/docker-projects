This dockerfile builds an ubuntu image filled with troubleshooting tols.

To use, make sure to use docker run specifying the nett, pid, and ipc namespaces of the container you want to troubleshoot
docker run --it -netd=container:<container-id> -pid=container:<container-id> --ipc=container:<container-id> bccourt/testing:tshoot

Dockerer run does not allow placing coniners in the same mount namespace, but if we run in the same ipc namespace, we can share files placed in /dev/shm as a dirty workaround