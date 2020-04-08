# satelit-infra

This repository contains everything that's necessary for running Satelit services in production.

Current structure is:

- [`docker`](docker) - contains common Docker images used by every service, such as DB or localstack.
- [`packer`](packer) - contains scripts to build disk images for cloud VMs.
- [`tf`](tf) - contains Terraform definition of all infrastructure required for running Satelit services.

The project currently relies on DigitalOcean for cloud VMs and data storage. Actual services are running in Docker containers and managed manually via Docker Compose to keep things simple.
