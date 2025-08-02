# 3-Tier DevSecOps Project

This repository contains a simple Node.js API and a React client used for a user management demo. Follow the steps below to get the project running locally.

## Setup

1. Install Node.js (version 18 or later is recommended).
2. Install dependencies for both the API and client:

   ```bash
   cd api && npm install
   cd ../client && npm install
   ```

3. Start the API server:

   ```bash
   cd api
   npm start
   ```

4. In a separate terminal, start the React client:

   ```bash
   cd client
   npm start
   ```

5. Open `http://localhost:3000` in your browser to use the application.

# ---------------------------------------------
# Docker Setup & SonarQube
# ---------------------------------------------

# Install Docker and Docker Compose
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io docker-compose -y

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add current user to Docker group and apply it
sudo usermod -aG docker ubuntu
newgrp docker

# Check Docker status
docker version
docker images
docker ps -a

# Run SonarQube container
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Start container if needed
docker start <container_id>  # e.g., docker start 4500edf4c17e


# ---------------------------------------------
# Install Gitleaks
# ---------------------------------------------

# Option 1: Install via APT
sudo apt install gitleaks

# Option 2: Install via script (latest version)
curl -s https://raw.githubusercontent.com/gitleaks/gitleaks/main/install.sh | bash

# Run gitleaks
gitleaks


# ---------------------------------------------
# Terraform Workflow
# ---------------------------------------------

cd aws-sre-actions/terraform

terraform init
terraform validate
terraform plan
terraform apply


# ---------------------------------------------
# EKS & CLI Tools Setup
# ---------------------------------------------

# Update kubeconfig to access the cluster
aws eks --region ca-central-1 update-kubeconfig --name awssreactions-eks

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

# Install eksctl
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz
sudo mv eksctl /usr/local/bin
eksctl version


# ---------------------------------------------
# EKS IAM OIDC & IRSA Setup (ebs-csi-controller-sa)
# ---------------------------------------------

# Associate IAM OIDC provider
eksctl utils associate-iam-oidc-provider \
  --region ca-central-1 \
  --cluster awssreactions-eks \
  --approve

# Create IRSA service account
eksctl create iamserviceaccount \
  --region ca-central-1 \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster awssreactions-eks \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve

# Check IRSA and related resources
aws eks describe-cluster --name awssreactions-eks --query "cluster.identity.oidc.issuer" --output text
aws iam list-open-id-connect-providers
kubectl get sa ebs-csi-controller-sa -n kube-system -o yaml

# If needed: Delete broken CloudFormation stack
aws cloudformation delete-stack \
  --stack-name eksctl-awssreactions-eks-addon-iamserviceaccount-kube-system-ebs-csi-controller-sa \
  --region ca-central-1


# ---------------------------------------------
# Deploy Cluster Addons
# ---------------------------------------------

# AWS EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.11"

# Ingress NGINX Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# Cert Manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
