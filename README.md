# Terraform & Ansible — AWS Infrastructure Automation

## Overview

This project automates AWS infrastructure provisioning and server configuration using **Terraform**, **Ansible**, and **Docker**.

Terraform provisions two Ubuntu EC2 instances on AWS, while Ansible connects to both servers, installs Docker, and deploys an Nginx container.

## Architecture

- **Cloud Provider:** AWS
- **Infrastructure as Code:** Terraform
- **Configuration Management:** Ansible
- **Containerization:** Docker
- **Web Server:** Nginx
- **Operating System:** Ubuntu
- **AWS Region:** eu-central-1 (Frankfurt)

## Infrastructure

Terraform provisions:

- 2 Ubuntu EC2 instances (`t3.micro`)
- 1 AWS Security Group
- SSH access (Port 22)
- HTTP access (Port 80)
- Application access (Port 5000)
- AWS SSH Key Pair

## Ansible Configuration

Ansible manages both EC2 instances through an inventory file.

The playbook performs the following tasks:

1. Updates Ubuntu packages.
2. Installs Docker.
3. Starts and enables the Docker service.
4. Pulls the official Nginx image.
5. Runs an Nginx container.
6. Maps host ports `80` and `5000` to container port `80`.

## Project Structure

```text
TerraformAnsible/
├── ansible/
│   ├── inventory.ini
│   └── playbook.yaml
├── main.tf
├── .gitignore
└── README.md
```

## Prerequisites

- AWS account
- AWS CLI
- Terraform
- Ansible
- SSH key pair
- Git

## Deployment

### 1. Clone the repository

```bash
git clone https://github.com/DavitM05/TerraformAnsible.git
cd TerraformAnsible
```

### 2. Configure AWS credentials

```bash
aws configure
```

Set your AWS region to:

```text
eu-central-1
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review infrastructure changes

```bash
terraform plan
```

### 5. Create AWS infrastructure

```bash
terraform apply
```

### 6. Configure Ansible inventory

Update `ansible/inventory.ini` with the public IP addresses of your EC2 instances and the correct SSH private key path.

### 7. Run the Ansible playbook

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yaml
```

## Verification

Check running Docker containers:

```bash
ansible webservers -i inventory.ini -b -m command -a "docker ps"
```

Test Nginx:

```bash
curl -I http://YOUR_EC2_PUBLIC_IP
```

Test port 5000:

```bash
curl -I http://YOUR_EC2_PUBLIC_IP:5000
```

Both endpoints should return an HTTP response from Nginx.

## Cleanup

To remove the AWS infrastructure created by Terraform:

```bash
terraform destroy
```

## Security Notes

- Never commit AWS credentials.
- Never upload SSH private keys.
- Never commit Terraform state files.
- Keep `.env` files and sensitive `.tfvars` files out of Git.
- Restrict SSH access to trusted IP addresses.

## Author

**Davit Mirzoyan**

GitHub: [@DavitM05](https://github.com/DavitM05)
