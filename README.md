# 🚀 MEAN Stack DevOps Deployment (Step-by-Step Guide)

## 🎯 Overview
This project demonstrates end-to-end deployment of a MEAN stack application using Docker, Nginx, CI/CD, and AWS EC2.

---

## 🧱 Step 1: Clone Repository
```bash
git clone https://github.com/<your-username>/<repo>.git
cd <repo>
```

---

## 🐳 Step 2: Build & Run Locally
```bash
docker compose up --build
```

Access:
http://localhost

---

## 🛠️ Step 3: Docker Hub Setup

### Login
```bash
docker login
```

### Tag Images
```bash
docker tag backend <your-username>/mean-backend:latest
docker tag frontend <your-username>/mean-frontend:latest
```

### Push Images
```bash
docker push <your-username>/mean-backend:latest
docker push <your-username>/mean-frontend:latest
```

---

## ☁️ Step 4: Setup EC2 VM

### Install Docker
```bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
```

### Clone Repo
```bash
git clone https://github.com/<your-username>/<repo>.git
cd <repo>
```

---

## 🔄 Step 5: Configure docker-compose.yml

Use Docker Hub images:
```yaml
backend:
  image: <your-username>/mean-backend:latest
frontend:
  image: <your-username>/mean-frontend:latest
```

---

## 🌐 Step 6: Setup Nginx

Create nginx/nginx.conf:

```nginx
events {}

http {
  server {
    listen 80;

    location / {
      proxy_pass http://frontend:80;
    }

    location /api/ {
      proxy_pass http://backend:8080/;
    }
  }
}
```

---

## 🚀 Step 7: Run on VM
```bash
docker compose up -d
```

---

## 🔄 Step 8: CI/CD (GitHub Actions)

Workflow:
- Build Docker images
- Push to Docker Hub
- SSH into VM
- Pull & restart containers

---

## 🔐 Required Secrets

- DOCKER_HUB_USERNAME
- DOCKER_HUB_TOKEN
- VM_HOST
- VM_USER
- VM_SSH_KEY

---

## ✅ Step 9: Verify

```bash
docker ps
```

Open:
http://<your-vm-ip>

---
