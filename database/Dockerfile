from mariadb:10.6
COPY setup.sh .

RUN apt update
RUN apt install -y curl p7zip-full
RUN bash ./setup.sh

RUN mv setup_files/* /docker-entrypoint-initdb.d/
