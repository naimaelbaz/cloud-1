# Cloud-1: Automated Deployment of Inception

Automated deployment of a WordPress site with MariaDB and Nginx on a cloud server using Ansible and Docker.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Cloud Server Setup](#cloud-server-setup)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Accessing Your Site](#accessing-your-site)
- [Managing the Application](#managing-the-application)
- [Project Structure](#project-structure)

## 🎯 Overview

This project deploys a complete WordPress website stack using:
- **Nginx** - Web server with TLS/SSL support
- **WordPress** - Content management system
- **MariaDB** - Database server
- **Docker** - Containerization (one process per container)
- **Ansible** - Automated deployment

All services run in separate containers, with data persistence and automatic restart on server reboot.

## ✅ Prerequisites

### Local Machine Requirements
- Ansible installed (`pip install ansible`)
- SSH key pair for cloud server access
- Git

### Cloud Server Requirements
- Ubuntu 20.04 LTS or similar
- SSH daemon running
- Python 3 installed
- Public IP address assigned

## ☁️ Cloud Server Setup

### 1. Launch a Cloud Instance

Choose a cloud provider (AWS, Azure, GCP, etc.) and launch an Ubuntu 20.04 instance.

**Recommended specs:**
- Instance type: t2.micro (AWS) or equivalent
- OS: Ubuntu 20.04 LTS
- Storage: 8-10 GB minimum
- Open ports: 22 (SSH), 443 (HTTPS)

### 2. Configure Security Group / Firewall

Allow inbound traffic on:
- Port 22 (SSH) - from your IP only
- Port 443 (HTTPS) - from anywhere (0.0.0.0/0)

### 3. Save Your SSH Key

Save your private key to `~/.ssh/inception-key.pem`:
```bash
chmod 400 ~/.ssh/inception-key.pem
```

## ⚙️ Configuration

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd cloud-1
```

### 2. Update Ansible Inventory

Edit `ansible/inventory.ini` with your server details:
```ini
[cloud_server]
inception ansible_host=YOUR_SERVER_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/inception-key.pem
```

### 3. Configure Environment Variables

Create `srcs/.env` file from the example:
```bash
cp srcs/.env.example srcs/.env
```

Edit `srcs/.env` with your values:
```bash
# Database Configuration
DB_NAME=myDb
DB_HOST=mariadb
DB_USER=root
DB_PASSWORD=your_secure_password

# WordPress Configuration
WP_SITE_TITLE=My WordPress Site
WP_ADMIN_USER=your_admin_username
WP_ADMIN_PASS=your_secure_password
WP_ADMIN_EMAIL=your_email@example.com

# Domain/IP
HOST=https://YOUR_SERVER_IP

# Optional: API keys for additional services
API_KEY=your_api_key
```

## 🚀 Deployment

### Automated Deployment with Ansible

Run the deployment playbook:
```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
```

This will:
1. Install Docker and Docker Compose on the server
2. Copy all necessary files
3. Build and start all containers
4. Configure auto-restart service

**Deployment time:** ~5-10 minutes


## 🌐 Accessing Your Site

Once deployed, access your WordPress site at:
```
https://YOUR_SERVER_IP
```

**Note:** You'll see a security warning because of the self-signed SSL certificate. This is normal. Click "Advanced" → "Proceed to site" in your browser.

### WordPress Admin Panel

Access the admin dashboard at:
```
https://YOUR_SERVER_IP/wp-admin
```

Login with:
- Username: Value from `WP_ADMIN_USER`
- Password: Value from `WP_ADMIN_PASS`

## 🔧 Managing the Application

### Check Container Status
```bash
ssh -i ~/.ssh/inception-key.pem ubuntu@YOUR_SERVER_IP
docker ps
```

### View Logs
```bash
# All containers
docker-compose -f ~/inception/docker-compose.yml logs

# Specific container
docker logs nginx
docker logs wordpress
docker logs mariadb
```

### Restart Services
```bash
cd ~/inception
docker-compose restart
```

### Stop Services
```bash
cd ~/inception
docker-compose down
```

### Update Deployment
After making changes locally:
```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
```

## 📁 Project Structure

```
cloud-1/
├── ansible/
│   ├── inventory.ini          # Server inventory
│   └── deploy.yml            # Deployment playbook
├── srcs/
│   ├── docker-compose.yml    # Container orchestration
│   ├── .env                  # Environment variables (not in repo)
│   └── requirements/
│       ├── mariadb/
│       │   ├── Dockerfile
│       │   ├── conf/my.cnf
│       │   └── tools/confMariadb.sh
│       ├── wordpress/
│       │   ├── Dockerfile
│       │   └── tools/script.sh
│       └── nginx/
│           ├── Dockerfile
│           └── conf/serverConfig.conf
└── README.md                 # This file
```

## 📝 License

This project is part of the 42 School curriculum.
