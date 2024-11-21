# Team 18 KC Hackathon: Dockerized Web Application

## Overview
This project is a web application designed for the Team 18 KC Hackathon. The application features a simple home page listing team member names. It is containerized using Docker with an Nginx web server and deployed on a Linux virtual machine (VM) through a private Docker Hub repository.

The CI/CD pipeline is implemented using GitHub Actions to automate the build, push, and deployment process. This guide provides all the steps necessary to set up, test, and deploy the application.

---

## Features
- A static web page with team member names and customizable background colors.
- Dockerized using Nginx for easy deployment.
- CI/CD pipeline integrated with GitHub Actions.
- Supports deployment on Linux VMs with a private Docker Hub repository.

---

## Prerequisites
1. Docker installed on your local machine.
2. A private Docker Hub repository named `abdulkyndryl/team-18-kc-hackathon`.
3. Access to a Linux VM with SSH (username, password, and FQDN).
4. GitHub account and repository for managing code and pipeline.

---

## Local Setup

### Clone the Repository
1. Clone the GitHub repository to your local machine:
   - git clone https://github.com/<your_github_username>/team-18-kc-hackathon.git
   - cd team-18-kc-hackathon

### Build the Docker Image
2. Build the Docker image locally:
   - docker build -t team-18-kc-hackathon .

### Test Locally
3. Run the Docker container:
   - docker run -d -p 8080:80 --name team-18-container team-18-kc-hackathon
4. Open your browser and navigate to `http://localhost:8080` to view the application.

---

## Push to Private Docker Hub Repository

1. Log in to Docker Hub using your credentials:
   - docker login --username abdulkyndryl --password <Your password>

2. Tag the Docker image for the private repository:
   - docker tag team-18-kc-hackathon abdulkyndryl/team-18-kc-hackathon:latest

3. Push the image to the private repository:
   - docker push abdulkyndryl/team-18-kc-hackathon:latest

---

## Deployment on Linux VM

1. Connect to the Linux VM via SSH using username and password.

2. Log in to Docker Hub from the VM:
   - docker login --username abdulkyndryl --password <DOCKERHUB_PASSWORD>

3. Pull the image from the private Docker Hub repository:
   - docker pull abdulkyndryl/team-18-kc-hackathon:latest

4. Stop and remove any existing container with the same name:
   - docker stop team-18-container || true
   - docker rm team-18-container || true

5. Run the container on the Linux VM:
   - docker run -d -p 80:80 --name team-18-container abdulkyndryl/team-18-kc-hackathon:1.0

6. Access the application via the Linux VM's FQDN (e.g., `http://<FQDN>`).

---

## CI/CD Pipeline with GitHub Actions

### Configuration
The GitHub Actions pipeline automates the following steps:
1. Build the Docker image.
2. Push the image to the private Docker Hub repository.
3. Deploy the image on the Linux VM.

### Workflow File
The CI/CD pipeline is defined in `.github/workflows/docker-pipeline.yml`. The pipeline triggers on pushes to the `main` branch.

### Secrets Setup
Configure the following GitHub Secrets in your repository:
1. `DOCKER_USERNAME`: Docker Hub username (e.g., `abdulkyndryl`).
2. `DOCKER_PASSWORD`: Docker Hub password.
3. `LINUX_USER`: SSH username for the Linux VM.
4. `LINUX_PASSWORD`: SSH password for the Linux VM.
5. `LINUX_HOST`: FQDN or IP address of the Linux VM.

### Triggering the Pipeline
Push changes to the `main` branch to trigger the CI/CD pipeline. The pipeline will automatically build, push, and deploy the latest version of the application.

---

## Customization

### Update the Web Page
1. Modify the `index.html` file to update content or styling. For example, change the background color from green to red:
   - body { background-color: red; }

2. Rebuild the Docker image:
   - docker build -t team-18-kc-hackathon .

3. Push the updated image to the private repository:
   - docker tag team-18-kc-hackathon abdulkyndryl/team-18-kc-hackathon:1.1
   - docker push abdulkyndryl/team-18-kc-hackathon:1.1

### Change Port Numbers
Run the container with a different port mapping:
   - docker run -d -p 8081:80 --name team-18-container abdulkyndryl/team-18-kc-hackathon:1.0

### Deploy Specific Versions
To deploy a specific version of the application:
   - docker pull abdulkyndryl/team-18-kc-hackathon:1.1
   - docker run -d -p 80:80 --name team-18-container abdulkyndryl/team-18-kc-hackathon:1.1

---

## Speeding Up CI/CD
1. Use Docker layer caching to avoid rebuilding unchanged layers.
2. Optimize the `Dockerfile` by reducing unnecessary layers.
3. Use parallel builds in GitHub Actions for multiple stages (e.g., build and test).

---

## License
This project is licensed under the MIT License. See the `LICENSE` file for more details.
