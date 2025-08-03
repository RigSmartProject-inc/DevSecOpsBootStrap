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

# 🚀 DevSecOps Bootstrap Setup Guide on Ubuntu

This guide provides a well-structured walkthrough to install and configure essential DevSecOps tools including Jenkins, Gitleaks, Trivy, Docker, Kubernetes, Terraform, and AWS CLI.

---

## 🔧 System Preparation

```bash
sudo apt update && sudo apt upgrade -y
```

---

## ☕ Install Java (Required for Jenkins)

```bash
sudo apt install openjdk-21-jre-headless -y
java -version
```

---

## 🧰 Install Jenkins

```bash
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

---

## 🔐 Install Gitleaks (SAST)

```bash
sudo rm -f /usr/local/bin/gitleaks
curl -LO https://github.com/gitleaks/gitleaks/releases/download/v8.18.1/gitleaks_8.18.1_linux_x64.tar.gz
tar -xzf gitleaks_8.18.1_linux_x64.tar.gz
sudo mv gitleaks /usr/local/bin/
sudo chmod +x /usr/local/bin/gitleaks
gitleaks version
rm gitleaks_8.18.1_linux_x64.tar.gz
```

---

## 🔍 Install Trivy (SCA & Image Scanner)

```bash
sudo apt install wget gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null
sudo apt update
sudo apt install trivy -y
trivy --version
```

---

## 🐳 Install Docker & Docker Compose

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

Check versions:

```bash
docker --version
docker compose version
```

---

## ☸️ Install Kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

Enable bash autocompletion:

```bash
sudo apt install bash-completion -y
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
source /etc/bash_completion.d/kubectl
```

---

## 🧪 (Optional) ZAP Proxy Docker Image

> ⚠️ ZAP images may be deprecated.

```bash
sudo docker pull owasp/zap2docker-stable:latest
```

---

## ✅ Verify Docker Installation

```bash
sudo docker run hello-world
```

---

## 📎 Jenkins Notes

```bash
# Jenkins default admin password:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Restart system after adding Jenkins to Docker group
sudo reboot
```

---

## 🔄 Common Maintenance Commands

```bash
docker ps
docker images
systemctl status jenkins
groups jenkins
```

---

## 📦 Clean Gitleaks Installations

```bash
sudo find / -type f -name gitleaks 2>/dev/null
sudo rm -f /path/to/old/gitleaks
```

---

## 🌐 API Health Checks

```bash
curl -f http://localhost:5000/api/health
curl -f http://<public-ip>:5000/api/health
```

---

# 🔨 DevSecOps Infrastructure Bootstrapping

---

## 🐳 Docker Basics

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io docker-compose -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
newgrp docker
```

## 🧪 Run SonarQube

```bash
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
docker ps -a
```

## ☁️ AWS CLI Setup

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
aws --version
aws configure
```

## 📦 Terraform Setup

```bash
wget https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_amd64.zip
unzip terraform_1.8.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -v
```

## 📁 Project Initialization

```bash
git clone https://github.com/HAFIS-DAVIES/aws-sre-actions.git
cd aws-sre-actions/terraform/
terraform init
```

## ☁️ Terraform Backend (S3 + DynamoDB)

```bash
aws s3api create-bucket --bucket infrabucket-awssreactions-ca-central-1 --region ca-central-1 --create-bucket-configuration LocationConstraint=ca-central-1
aws s3api put-bucket-versioning --bucket infrabucket-awssreactions-ca-central-1 --versioning-configuration Status=Enabled
aws dynamodb create-table --table-name terraform-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --region ca-central-1
```

## 📦 Terraform Lifecycle

```bash
terraform validate
terraform plan
terraform apply
terraform destroy --auto-approve
```

## ☸️ Kubernetes Tools

```bash
# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

# eksctl
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz
sudo mv eksctl /usr/local/bin
```

## ☁️ Amazon EKS Setup

```bash
aws eks --region ca-central-1 update-kubeconfig --name awssreactions-eks
eksctl utils associate-iam-oidc-provider --region ca-central-1 --cluster awssreactions-eks --approve
eksctl create iamserviceaccount --region ca-central-1 --name ebs-csi-controller-sa --namespace kube-system --cluster awssreactions-eks --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy --approve --override-existing-serviceaccounts
```

## 🔏 RBAC for Kubernetes

```bash
kubectl create ns dev
kubectl apply -f sa.yaml
kubectl apply -f rbac.yaml
kubectl apply -f rbind.yaml
kubectl apply -f clusterrole.yaml
kubectl apply -f clusterrolebind.yaml
kubectl apply -f sa_token.yaml -n dev
kubectl describe secret mysecretname -n dev
```

## 📥 DevSecOps Bootstrap Git Setup

```bash
git clone https://github.com/RigSmartProject-inc/DevSecOpsBootStrap.git
cd DevSecOpsBootStrap/
git checkout -b dev origin/dev
```

---