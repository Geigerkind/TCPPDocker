FROM ubuntu:20.04
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y libmariadbclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev libmariadb-client-lgpl-dev-compat mariadb-server screen
COPY ./start.sh /
ENTRYPOINT ["/bin/bash", "/start.sh"]
