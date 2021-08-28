# Running TrinityCore with Docker
There are 4 different services.

## Trinity_db
Set ups a current database with the world and patches of the latest release. It exposes the port `3306`. If that port is taken on your system, you need to change the mapping in `docker-compose.db.yml`. The database user is `trinity` with the password `trinity`.

## Builder
The builder is a helper tool that builds the latest TrinityCore and puts the respective executables in separate volumes. It also configures the config files such that they work within the docker network. This container needs to be run at least once.

## Auth
Runs the `bnetserver` within a screen. To access it, connect to the running container with an interactive `bash`. After that you can attach to the screen via `screen -S auth -r`.

## World
Runs the `worldserver` within a screen. To access it, connect to the running container with an interactive `bash`. After that you can attach to the screen via `screen -S world -r`. Please configure the `docker-compose.world.yml` to point to your `data` directory, containing `dbc`, `maps` and `vmaps`. MMaps are currently disabled, but can be disabled by changing the `builder/copy_binaries.sh`.

## Running the container
```
docker-compose -f docker-compose.builder.yml -f docker-compose.db.yml -f docker-compose.auth.yml -f docker-compose.world.yml up
```
