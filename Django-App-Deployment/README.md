
# Django App Deployment Script 

This repository contains a shell script (`deploy_django_app.sh`) to automate the deployment of a **Django application** with **Docker**, **Docker Compose**, and **Nginx**.

##  Features
- Clones your Django project repository.
- Installs dependencies:
  - **Docker**
  - **Docker Compose**
  - **Nginx**
- Builds Docker images for:
  - Django application
  - Nginx
  - Database (MySQL/Postgres depending on your project)
- Deploys services using `docker compose`.
- Runs Django, Nginx, and database containers.

## 🛠️ Requirements
- Ubuntu (20.04+ recommended)
- Git installed
- Sudo privileges

## 📂 Project Structure (after running script)
```

Shell-Scripts/
│── deploy\_django\_app.sh   # Main deployment script
│── django-notes-app/      # Cloned Django project
│   ├── Dockerfile
│   ├── docker-compose.yml
│   ├── requirements.txt
│   └── ...

