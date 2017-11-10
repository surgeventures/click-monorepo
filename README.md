## Running the system

Rebuild & run containers and return exit code:

    docker-compose --file <compose-file> up --build --abort-on-container-exit [<service> ...]

Rebuild & run containers as daemons:

    docker-compose --file <compose-file> up --daemon [<service> ...]

Run one-shot command in specific container:

    docker-compose --file <compose-file> run --rm <service> <command>

Files available for `<compose-file>`:

- `docker/dev/docker-compose.yml` - development setup of entire system
- `docker/test-integration/docker-compose.yml` - integration test of entire system
- `apps/<service>/docker/test-isolated/docker-compose.yml` - isolated test for specific service
