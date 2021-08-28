FROM ubuntu:20.04
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y git clang cmake make gcc g++ libmariadbclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip libmariadb-client-lgpl-dev-compat curl
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100

RUN git clone --depth 1 --branch $(curl --silent "https://api.github.com/repos/The-Cataclysm-Preservation-Project/TrinityCore/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') https://github.com/The-Cataclysm-Preservation-Project/TrinityCore.git
RUN mkdir TrinityCore/build
WORKDIR TrinityCore/build
RUN cmake ../
RUN make -j$(grep processor /proc/cpuinfo | wc -l)

COPY ./copy_binaries.sh /
ENTRYPOINT ["/bin/bash", "/copy_binaries.sh"]
