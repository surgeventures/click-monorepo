## Running the system

Rebuild & run containers and return exit code:

    docker-compose up --build --abort-on-container-exit [<service> ...]

Rebuild & run containers as daemons:

    docker-compose up --daemon [<service> ...]

Run one-shot command in specific container:

    docker-compose run --rm <service> <command>

There are following contexts in which you can invoke `docker-compose`:

- `/` - development setup of entire system
- `/apps/<service>` - unit test for specific service
- `/tests/integration` - integration test of entire system
