FROM ubuntu:trusty

RUN \
    apt-get update \
    && apt-get -y install gcc wget ca-certificates git \
    autoconf automake libtool curl make g++ unzip bzip2 \
    libprotobuf-dev libprotobuf-c0-dev protobuf-c-compiler \
    protobuf-compiler python-protobuf libnl-3-dev libcap-dev \
    python-yaml libaio-dev libnet-dev

RUN \
   wget -q https://download.openvz.org/criu/criu-3.10.tar.bz2 \
   && bzip2 -d criu-3.10.tar.bz2

RUN \
    tar -xvf criu-3.10.tar

# RUN sed -i 's/SECCOMP_MODE_DISABLED 0/SECCOMP_MODE_DISABLED 2/' criu-3.10/compel/src/lib/infect.c
RUN sed -i '28s|return -1|return 0|' criu-3.10/compel/src/lib/ptrace.c
RUN sed -i '1817s|goto err||' criu-3.10/criu/cr-dump.c

RUN cd criu-3.10    \
    && make
