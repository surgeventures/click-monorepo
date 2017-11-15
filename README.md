# click-monorepo

Sample integrated system with multiple micro-services, organized as mono-repo.

Features:

- uses the monorepo pattern in order to reduce the complexity of system-wide code management
- organizes microservice applications and cross-service tests
- organizes Docker configuration for multiple contexts, such as development or tests
- includes an optimized configuration for running integration on CircleCI

## Docker contexts

This repository contains multiple so-called Docker contexts, each with its dedicated Compose file or
set of Compose files, allowing to manage the system or its part against a specific use case.
Sections below describe each Docker context in detail.

### `dev`

Represents the development setup of the entire system and each service within it. It may be started
in a variety of ways, depending on required services and intended terminal behavior.

In usual case, you'll want to start everything except for the service that is being developed. That
can be done with the following set of commands:

    docker-compose up --daemon
    docker-compose stop <service-in-development>

You may drop the last command in order to have an entire system in development setup.

You may want to run a one-shot command against specific service (such as running seeds or
migrations). Here's how:

    docker-compose run --rm <service> <command>

You may also want to preview logs for running services in order to debug issues in them. Here's how:

    docker-compose logs --follow

### `test`

Represents isolated (sometimes referred to as component tests in the microservice community) tests
of a specific service.

In usual case, you'll want to test the service that is being developed without involving Docker in
order to have the shortest feedback loop possible. Running them via Docker Compose ensures that
external dependencies required by component tests (such as test database) are also set up.

They can be run (most likely but not necessarily on a CI) with a single command invoked from the
`apps/<app>` directory:

    docker-compose up --build --abort-on-container-exit

### `e2e`

Represents end-to-end tests of the entire system, run against multiple Selenium drivers (`chrome`
and `firefox` in the current setup).

They can be run with a single command invoked from the `tests/e2e` directory:

    docker-compose up --build --abort-on-container-exit <chrome|firefox>

The command above will return with exit status `0` if build and test run is successful.

In addition, the command above will output the following content:

- `/tmp/<chrome|firefox>-screenshots` - screenshots
- `/tmp/<chrome|firefox>-html-reports` - HTML reports
- `/tmp/<chrome|firefox>-junit-reports` - JUnit reports

## Directory structure

```sh
.circleci
  config.yml              # (1)
apps
  app1                    # (2)
    docker                # (3)
      dev                 # (4)
      ...
    docker-compose.yml    # (5)
  ...
tests
  e2e                     # (6)
    docker                # (7)
    docker-compose.yml    # (5)
  ...
docker-compose.yml        # (5)
```

Legend:

1. CircleCI config is placed in the `/.circleci` directory.

2. Each application is placed in the `/apps` directory.

3. Each application holds all its Docker setup (except for Compose file) in `docker` subdirectory.

4. Each application splits its Docker setup into subdirectories within `docker` for each required
   [Docker context](#docker-contexts).

5. Each Docker context has its Compose file placed in the place chosen as most logical and
   convenient for it in the repository structure ([more info](#docker-contexts)).

6. Each test suite, starting with end-to-end tests in `e2e` and optionally followed by others such
   as performance tests, is placed in `/tests` directory.

7. Each test suite holds all its Docker setup in `docker` subdirectory.

### Reasoning

Here's a more thorough explanation of each of the decisions behind the directory structure.

#### Applications

It's hard to define a clear semantic separation of applications (such as `frontend` and `backend`)
because of such responsibilities often being shared and mixed (such as a SPA front-end application
having a backend component for SSR or backend applications being a mix of completely internal
background processors vs JSON APIs vs HTML renderers).

Therefore, the `apps` directory was introduced to keep the applications in one place separate from
tests or integration config, but no further nesting was applied.

#### Per-application Docker setup

Docker setup for specific application is usually similar across contexts, therefore holding it
within application directory - even when it's really used by a context from outside the application
directory as is the case with `dev` or `e2e` - makes up for easiest possible creation and
maintenance of all Docker setups for specific application.

Holding Docker setup inside application directory and nested within `docker` subdirectory ensures:

- these files don't pollute the application root
- they appear next to each other in diffs
- the project outside `docker` stays separated from and unaware of the Docker layer
- we can use the application directory as context for `Dockerfile` and `COPY` commands

> It's worth noting as a counter-point that modifications to Docker contexts other than `test` will
  unnecessarily bust per-app CircleCI build caches ([more info](#circleci-configuration)). It's not
  considered a big deal due to expected infrequent changes there and the fact that those changes
  will usually touch the `test` context as well.

#### Docker contexts

Each Docker context requires a considerable amount of similarly named files (such as `Dockerfile`).
Therefore the setup for each of them was put into a separate subdirectory in order to keep things
clean and uncluttered.

#### Compose files

It's convenient to place `docker-compose.yml` for each context in the most logical place in the
repository structure (and in case of applications outside of the `docker` subdirectory) in order to
allow an easy and intuitive usage of the `docker-compose` command (along with convenient aliases)
without the `--file` parameter.

#### Test suites

Each test suite represents a test unit that requires a dedicated Docker context. This means that an
appropriate Docker context inside `apps/<app>/docker/<context>` should be filled for all
applications required by the suite's Compose file.

## CircleCI configuration

There's a working monorepo config provided in the `.circleci` directory. Here's what it does:

1. Runs the `test` context for each application (in parallel).
2. Prebuilds the `e2e` context.
3. Runs the `e2e` context for each Selenium driver (in parallel).

In case of a failure during any of the above steps, the subsequent steps are not executed.

CircleCI setup has the following traits:

- Remote Docker is used in order to build everything using Compose files instead of duplicating
  their setup directly in the `.circleci/config.yml`
- Docker layer caching is enabled in order to ensure that unchanged parts of Docker builds are not
  built again after they were already built before
- Dependency caching is used in order to avoid re-running isolated tests that were already
  succesfully run before against the same version of specific application
- `e2e-prebuild` job is executed before per-driver end-to-end tests in order to ensure that Docker
  layer caching is fully utilized by parallel per-driver jobs
- Artifacts and test results are stored in order to persist them for build debugging and integration
  with CircleCI test insights facilities
- `docker cp` is used to take the build artifacts out of the Remote Docker environment back into
  the primary container, from which the CircleCI can upload them further
