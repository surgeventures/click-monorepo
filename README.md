# click-monorepo

Features:

- embraces the monorepo pattern in order to reduce the complexity of code management
- includes multiple sample applications that make for a working microservice system
- includes end-to-end test suite that uses Selenium with multiple web drivers
- uses Docker for setting up and running development, tests and production in a consistent way
- uses CircleCI for running isolated and end-to-end tests in the cloud
- organizes microservice applications and cross-service tests
- organizes Docker setup for multiple apps and contexts, such as development or test
- includes an optimized configuration for running efficient integration on CircleCI

## Docker contexts

We use a term "Docker contexts" to describe a single Compose file or a set of Compose files that
allow to manage the system or its part in a specific use case. Sections below describe each Docker
context in detail.

### `dev`

Represents the development setup of the entire system and each service within it. It may be started
in a variety of ways, depending on required services and intended terminal behavior.

In usual case, you'll want to start everything except for the service that is being developed (in
order to interact with it directly and efficiently). Run the following commands from the monorepo
root:

    docker-compose up --daemon
    docker-compose stop <service-in-development>

You may drop the last command in order to have and be able to interact with (eg. for debugging
purposes) an entire system in development environment.

You may want to run a one-shot command against specific service (such as running seeds or
migrations). Run the following command:

    docker-compose run --rm <service> <command>

You may also want to preview logs for running services in order to debug issues in them. Run the
following command:

    docker-compose logs --follow

### `test`

Represents isolated tests (sometimes called "component tests" in the microservice community) of a
specific application. These tests may require external dependencies for testing purposes, such as a
database or a service mock, but they never depend on other applications.

In usual case, you'll want to test the application that is being developed without involving Docker
in order to have the shortest feedback loop possible.

In order to execute them and receive a build & test exit status, run the following command from the
`/apps/<app>` directory:

    docker-compose up --build --abort-on-container-exit

### `e2e`

Represents cross-application end-to-end tests of the entire system, run against multiple Selenium
drivers, such as `chrome` and `firefox`.

In order to execute them and receive a build & test exit status, run the following command from the
`tests/e2e` directory:

    docker-compose up --build --abort-on-container-exit <chrome|firefox>

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
      ...contexts
    docker-compose.yml    # (5)
  ...apps
tests
  e2e                     # (6)
    docker                # (7)
    docker-compose.yml    # (5)
  ...test-suites
docker-compose.yml        # (5)
```

Legend:

1. CircleCI config is placed in the `/.circleci` directory (enforced by the service).

2. Each application is placed in the `/apps` directory.

3. Each application holds all its Docker setup (except for Compose file) in `docker` subdirectory.

4. Each application splits its Docker setup into subdirectories within `docker` for each required
   [Docker context](#docker-contexts).

5. Each Docker context has its Compose file placed in the most convenient location in the
   repository.

6. Each test suite, starting with end-to-end tests in `e2e` (later `perf` and more), is placed in
   `/tests` directory.

7. Each test suite holds all its Docker setup in `docker` subdirectory.

### Reasoning

Here's a more thorough explanation of each of the decisions behind the directory structure.

#### Applications

Although this repo only contains a handful of sample applications, microservice systems often have
dozens of them. Therefore, they should be kept separate from integrated tests and other global
content.

It's hard to define a clear semantic separation of applications (such as `frontend` and `backend`)
because of such responsibilities often being shared and mixed (such as a SPA front-end application
having a backend component for SSR or backend applications being a mix of completely internal
background processors vs JSON APIs vs HTML renderers).

Therefore, the `apps` directory was introduced to keep the applications in one place separate from
tests or integration config, but no further nesting was applied.

#### Per-application Docker setup

Depending on the application, there may be a lot of files required for a complete Docker setup.
Assuming that Docker setup is just a tooling/deployment choice made and built on top of the actual
application code, it makes sense to keep it separate without mixing it with the rest of the
application.

Docker setup for specific application is usually similar across contexts, therefore holding it
within application directory - even when it's really used by a context from outside the application
directory as is the case with `dev` or `e2e` - makes up for the easiest possible creation and
maintenance of Docker setup for all Docker contexts required by specific application.

Holding Docker setup inside application directory and nested within `docker` subdirectory has the
following advantages:

- Docker setup doesn't pollute the application structure
- project outside `docker` stays separated from and unaware of the Docker layer
- changes in specific application's Docker setup is grouped together in diffs
- application root can be used as context for `Dockerfile` and `COPY` commands
- addition of new Docker-ready applications is a matter of copy-pasting existing `docker` directory

#### Docker contexts

Each Docker context requires a considerable amount of similarly named files (such as `Dockerfile`).
Therefore the setup for each of them was put into a separate subdirectory in order to keep things
clean and uncluttered.

#### Compose files

It's convenient to place the Compose file with a default name `docker-compose.yml` for each context
in the most logical, natural and intuitive place in the repository structure (and in case of
applications outside of the `docker` subdirectory) in order to allow an easy and intuitive usage of
the `docker-compose` command (along with convenient aliases) without the `--file` parameter.

#### Test suites

Each test suite represents a test unit that requires a dedicated Docker context. This means that an
appropriate Docker context inside `apps/<app>/docker/<context>` should be filled for all
applications required by the suite's Compose file.

If multiple test suites can share a single Docker context, then they should be organized under a
single sub-directory within `/tests/<test-suite`. This makes for less Docker image builds and
an utilization of Docker build cache to the fullest.

## CircleCI configuration

There's a working monorepo config provided in the `.circleci` directory. It provides a `ci`
workflow, which executes the following actions in parallel:

- runs the `test` context for each application (each app in parallel)
- prebuilds and runs the `e2e` context for each Selenium driver (each driver in parallel)

CircleCI setup has the following traits:

- Remote Docker is used in order to consistently build everything using Compose files instead of
  duplicating their setup directly in the `.circleci/config.yml`
- Docker layer caching is enabled in order to ensure that unchanged parts of Docker builds are not
  built again after they were already built before (enabled per CircleCI customer request)
- Dependency caching is used in order to avoid re-running isolated tests that were already
  succesfully run before against the same checksum of specific application
- `e2e-prebuild` job is executed before per-driver end-to-end tests in order to ensure that Docker
  layer caching is fully utilized by parallel per-driver jobs
- artifacts and test results from the `e2e` test suite are stored in order to persist them for build
  debugging and integration with CircleCI test insights facilities
- `docker cp` is used to take the build artifacts out of the Remote Docker environment back into
  the primary container, from which the CircleCI can upload them further

## Possible improvements

The current setup already solves many technical issues related to monorepo, CI and Docker. Still, a
number of improvements and additions is possible, including:

- sample client/server JS application with `jest` and `eslint` checks
- sample Ruby on Rails application with `rake test` and `rubocop` checks
- sample Cordova application on top of JS application
- `mix test` integration with CircleCI test results
- `rake test` integration with CircleCI test results
- `jest` integration with CircleCI test results
- test suite for performance/scalability testing
- setup for Cordova mobile app build and testing
- setup for end-to-end testing on non-Dockerized browsers
- continuous review-app/production deployment with CircleCI & Docker
