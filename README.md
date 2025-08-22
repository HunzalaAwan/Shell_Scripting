#  Shell Scripting Projects  

This repository contains a collection of **Shell scripting projects** that demonstrate my skills in automating deployments, managing infrastructure, and working with
 Linux environments.  
Each project is structured in its own folder with dedicated scripts and documentation.  

---

## 📂 Repository Structure  

```

shell-scripting/
│
├── django-deployment/     # Automates deployment of a Django Notes App with Docker & Docker Compose
│   ├── deploy.sh
│   ├── docker-compose.yml
│   └── README.md
│
├── aws-ec2-automation/    # Installs & configures AWS CLI, launches an EC2 instance in default VPC
│   ├── aws-ec2.sh
│   └── README.md
│
└── README.md              # Main documentation

````

---

## 🚀 Projects  

### 1. **Django Deployment with Docker & Docker Compose**  
- Automates the process of:  
  - Cloning a Django application repository  
  - Installing Docker & dependencies  
  - Building Docker images  
  - Running the app via Docker Compose (with Nginx, Django, and DB containers)  
- Includes error handling for dependency installation & container failures  

👉 [See Project Details](./django-deployment/README.md)

---

### 2. **AWS CLI & EC2 Automation**  
- Installs and configures **AWS CLI** (if missing)  
- Creates an **EC2 Key Pair** and saves the `.pem` locally  
- Creates a **Security Group** in the default VPC with SSH access  
- Launches an **Ubuntu EC2 Instance**  
- Handles errors gracefully  
- Provides cleanup commands to terminate instance, delete security group, and remove key pair  

👉 [See Project Details](./aws-ec2-automation/README.md)

---

## 🛠️ Skills Demonstrated  

- **Linux system administration** (package installation, process management)  
- **Automation** with Bash functions and error handling  
- **Docker & Docker Compose** (multi-container deployments)  
- **AWS CLI** (EC2, VPC, Security Groups, Key Pairs)  
- **Scripting Best Practices**:  
  - Modularity (functions for each step)  
  - Error handling (`set -e`, condition checks)  
  - Logging & informative outputs  
  - Cleanup procedures  

---

##  How to Use  

Clone this repo:  
```bash
git clone https://github.com/<HunzalaAwan>/shell-scripting-projects.git
cd shell-scripting
````

Navigate to any project folder and run the scripts:

```bash
cd django-deployment
./deploy.sh
```

---

##  Future Plans

* Add **Kubernetes automation scripts**
* Write **backup & monitoring scripts** for Linux servers
* Create **CI/CD pipeline scripts** using Jenkins and GitHub Actions

---


