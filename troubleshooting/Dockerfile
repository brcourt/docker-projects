FROM ubuntu

RUN apt-get update
RUN apt-get install -y dnsutils telnet curl wget tar tcpdump procps iputils-ping net-tools iproute2 python3-pip zip

RUN ln -s /bin/bash /bin/bash__tshoot-entrypoint
RUN echo "PS1='${debian_chroot:+($debian_chroot)}\u@TSHOOT-->\h:\w\$ '" >> /root/.bashrc

ENTRYPOINT ["/bin/bash__tshoot-entrypoint"]
