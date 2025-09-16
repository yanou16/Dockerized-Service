# Dockerized Node.js Service with CI/CD Pipeline

## Overview
<img width="1676" height="853" alt="image" src="https://github.com/user-attachments/assets/a6463047-b28a-43a5-bbfd-703c1795bfd2" />
https://roadmap.sh/projects/dockerized-service-deployment
<img width="993" height="448" alt="image" src="https://github.com/user-attachments/assets/9335487d-1ae3-4004-8ca1-996e11d1071f" />

This project demonstrates a complete CI/CD workflow for a Node.js application, containerized with Docker and automatically deployed to a Google Cloud Platform (GCP) virtual machine using GitHub Actions.

## Project Structure
- Node.js Express application with public and protected routes
- Docker containerization
- Infrastructure as Code using Terraform for GCP
- Automated deployment pipeline with GitHub Actions

## Features

### Node.js Application
- Public endpoint (`/`) returning "Hello, world!"
- Protected endpoint (`/secret`) using Basic Authentication
- Environment variables for configuration

### Docker Configuration
- Node.js 18 Alpine base image
- Optimized for production use
- Environment variables support

### Infrastructure (Terraform)
- GCP Compute Engine VM instance (e2-micro)
- Automatic setup of Docker and dependencies
- Firewall rules for ports 22 (SSH), 80 (HTTP), 443 (HTTPS), and 3000 (Application)

### CI/CD Pipeline (GitHub Actions)
- Automated builds on push to main branch
- Container publishing to GitHub Container Registry
- Deployment to GCP VM using gcloud CLI
- Secure handling of credentials and environment variables

## Setup and Deployment

### Prerequisites
- GitHub account
- Google Cloud Platform account
- Terraform (for infrastructure provisioning)

### Local Development
1. Clone the repository
2. Create a `.env` file with the following variables:

```
SECRET_MESSAGE=your_secret_message
AUTH_USERNAME=your_username
AUTH_PASSWORD=your_password
```
3. Install dependencies: `npm install`
4. Run the application: `node server.js`
5. Access at http://localhost:3000

### Deployment Configuration

#### GitHub Secrets
Set up the following secrets in your GitHub repository:

- `CR_PAT`: GitHub Container Registry personal access token
- `GCP_SA_KEY`: GCP Service Account key (JSON format)
- `GCP_PROJECT_ID`: Your GCP project ID
- `VM_NAME`: Name of your VM instance
- `VM_ZONE`: Zone where your VM is located
- `SECRET_MESSAGE`: The secret message to display
- `AUTH_USERNAME`: Username for Basic Authentication
- `AUTH_PASSWORD`: Password for Basic Authentication

#### Deployment Process
1. Push changes to the main branch
2. GitHub Actions workflow automatically:
- Builds the Docker image
- Pushes to GitHub Container Registry
- Deploys to the GCP VM
- Sets up environment variables
- Runs the container

3. Access your application at `http://<VM_IP>:3000`

## Monitoring and Maintenance

### Checking Deployment Status
- View workflow runs in the GitHub Actions tab
- Check container logs on the VM:
```bash
gcloud compute ssh <VM_NAME> --zone=<VM_ZONE>
docker logs nodejs-app```

### Updating the Application
- Make changes to the code
- Push to the main branch
- GitHub Actions will automatically deploy the updates
## Security Considerations
- Sensitive information stored as GitHub Secrets
- Basic Authentication for protected endpoints
- Environment variables for configuration
- Firewall rules limiting access to necessary ports
## Future Improvements
- Add automated testing
- Implement HTTPS with Let's Encrypt
- Set up monitoring and alerting
- Add database integration
- Implement horizontal scaling
