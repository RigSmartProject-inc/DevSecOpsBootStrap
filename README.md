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

   1  docker images
    2  sudo systemctl enable docker
    3  sudo systemctl start docker
    4  docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
    5  docker ps
    6  sudo apt update
    7  sudo apt update && sudo apt upgrade -y
    8  clear
    9  sudo apt install docker.io docker-compose -y
   10  sudo usermod -aG docker ubuntu
   11  docker
   12  docker images
   13  newgrp docker
   14  docker ps
   15  docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
   16  clear
   17  docker ps -a
   18  docker start 4500edf4c17e
   19  docker ps
   20  gitleaks
   21  sudo apt install gitleaks
   22  curl -s https://raw.githubusercontent.com/gitleaks/gitleaks/main/install.sh | bash
   23  clear
   24  ls
   25  cd aws-sre-actions/
   26  ls
   27  cd terraform/
   28  ls
   29  terraform init
   30  terraform validate
   31  terraform plan
   32  terraform apply
   33  aws eks --region ca-central-1 update-kubeconfig --name awssreactions-eks
   34  curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   35  chmod +x kubectl
   36  sudo mv kubectl /usr/local/bin/
   37  kubectl version --client
   38  curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz
   39  sudo mv eksctl /usr/local/bin
   40  eksctl version
   41  eksctl utils associate-iam-oidc-provider --region ca-central-1 --cluster awssreactions-eks --approve
   42  eksctl create iamserviceaccount --region ca-central-1 --name ebs-csi-controller-sa --namespace kube-system --cluster awssreactions-eks --attach-policy-arn arn:aws:iam:aws:policy/service-role/AmazonEBSCSIDriverPolicy --approve --override-existing-serviceaccounts
   43  aws eks describe-cluster   --name awssreactions-eks   --query "cluster.identity.oidc.issuer"   --output text
   52  aws iam list-open-id-connect-providers
   53  eksctl create iamserviceaccount   --region ca-central-1   --name ebs-csi-controller-sa   --namespace kube-system   --cluster awssreactions-eks   --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy   --approve   --override-existing-serviceaccounts
   54  kubectl get sa ebs-csi-controller-sa -n kube-system -o yaml
   55  aws cloudformation delete-stack   --stack-name eksctl-awssreactions-eks-addon-iamserviceaccount-kube-system-ebs-csi-controller-sa   --region ca-central-1
   56  eksctl create iamserviceaccount   --region ca-central-1   --name ebs-csi-controller-sa   --namespace kube-system   --cluster awssreactions-eks   --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy   --approve
   57  kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.11"
   58  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
   59  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml




