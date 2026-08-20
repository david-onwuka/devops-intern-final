# DevOps Intern Final Assessment

![CI](https://github.com/david-onwuka/devops-intern-final/actions/workflows/ci.yml/badge.svg)

**Name:** David Onwuka  
**Date:** August 20, 2026

## Project Description

This project demonstrates a basic DevOps workflow using Linux, Bash, Git, GitHub, Docker, GitHub Actions, Nomad, Grafana Loki, Promtail, and Python.

The project covers source code management, Linux scripting, containerization, continuous integration, container deployment, and centralized log aggregation.

## Technologies Used

- Linux
- Bash
- Git
- GitHub
- Python
- Docker
- GitHub Actions
- Nomad
- Grafana Loki
- Promtail

---

# 1. Git & GitHub Setup

The project is hosted in a public GitHub repository:

https://github.com/david-onwuka/devops-intern-final

The repository contains the application source code, Linux script, Docker configuration, CI workflow, Nomad job, and Loki/Promtail configuration.

### Application

The `hello.py` application prints:

    Hello, DevOps!

Run it with:

    python hello.py

Expected output:

    Hello, DevOps!

---

# 2. Linux & Bash Scripting

The Linux system information script is located at:

    scripts/sysinfo.sh

The script displays:

- Current user
- Current date
- Disk usage

Make the script executable:

    chmod +x scripts/sysinfo.sh

Run it:

    ./scripts/sysinfo.sh

The script uses Linux commands including:

    whoami
    date
    df -h

---

# 3. Docker

The application is containerized using the `Dockerfile`.

### Build the Docker image

From the project root:

    docker build -t devops-hello:latest .

### Run the container

    docker run --rm devops-hello:latest

Expected output:

    Hello, DevOps!

### Check container logs

For persistent log testing:

    docker run --name devops-hello devops-hello:latest

Then:

    docker logs devops-hello

Expected output:

    Hello, DevOps!

---

# 4. CI/CD with GitHub Actions

The GitHub Actions workflow is located at:

    .github/workflows/ci.yml

The workflow runs automatically on pushes and pull requests.

The CI pipeline performs the following steps:

1. Checks out the repository.
2. Sets up Python 3.12.
3. Runs `hello.py` and verifies the expected output.
4. Makes the Linux shell script executable and runs it.
5. Builds the Docker image.
6. Runs the Docker container.
7. Verifies that the container outputs `Hello, DevOps!`.

This provides automated validation of the Python application, Linux script, and Docker image.

The CI status is displayed using the badge at the top of this README.

---

# 5. Nomad Deployment

The Nomad job definition is located at:

    nomad/hello.nomad

The job uses the Docker driver and the image:

    devops-hello:latest

The job uses:

    type = "batch"

because the application prints its message and exits instead of running as a long-lived service.

### Build the image

    docker build -t devops-hello:latest .

### Run the Nomad job

From the `nomad` directory:

    nomad job run hello.nomad

The job runs the Docker image and executes the application.

---

# 6. Grafana Loki + Promtail Monitoring

The monitoring configuration is located in:

    monitoring/
    ├── docker-compose.yml
    ├── promtail-config.yml
    └── loki_setup.txt

Loki provides log storage and querying.

Promtail reads Docker container logs and forwards them to Loki.

### Start Loki and Promtail

From the `monitoring` directory:

    docker compose up -d

Check the containers:

    docker ps

Check that Loki is ready:

    curl http://localhost:3100/ready

Expected response:

    ready

### Build and run the application

From the project root:

    docker build -t devops-hello:latest .

Run the application:

    docker run --name devops-hello devops-hello:latest

Check the application logs:

    docker logs devops-hello

Expected output:

    Hello, DevOps!

### Query logs from Loki

Use the Loki HTTP API:

    curl -G -s "http://localhost:3100/loki/api/v1/query_range" \
      --data-urlencode 'query={container="devops-hello"}' \
      --data-urlencode 'limit=10'

The response should contain the application log:

    Hello, DevOps!

The complete logging flow is:

    devops-hello container
            |
            v
    Docker container logs
            |
            v
        Promtail
            |
            v
          Loki
            |
            v
        LogQL query

Additional Loki setup details are documented in:

    monitoring/loki_setup.txt

---

# 7. Project Structure

    devops-intern-final/
    │
    ├── README.md
    ├── hello.py
    ├── Dockerfile
    │
    ├── scripts/
    │   └── sysinfo.sh
    │
    ├── .github/
    │   └── workflows/
    │       └── ci.yml
    │
    ├── nomad/
    │   └── hello.nomad
    │
    └── monitoring/
        ├── docker-compose.yml
        ├── promtail-config.yml
        └── loki_setup.txt

---

# 8. Expected DevOps Workflow

The complete workflow demonstrated by this project is:

    Git/GitHub
        |
        v
    Python Application
        |
        v
    Linux Script Validation
        |
        v
    Docker Build
        |
        v
    GitHub Actions CI
        |
        v
    Nomad Deployment
        |
        v
    Docker Logs
        |
        v
    Promtail
        |
        v
    Grafana Loki
        |
        v
    LogQL Query

---

# 9. Assessment Evidence

The repository contains the code, configuration, and documentation required for the assessment.

Recommended evidence/screenshots include:

- GitHub repository
- Successful GitHub Actions run
- Python application output
- Linux script output
- Docker build and container output
- Nomad job execution
- Loki and Promtail containers
- Loki log query showing `Hello, DevOps!`

---

# Conclusion

This project demonstrates practical use of Git, GitHub, Linux, Bash, Docker, GitHub Actions, Nomad, Promtail, and Grafana Loki in a small DevOps workflow.

The components are documented with commands and expected outputs so that the workflow can be reproduced locally.
