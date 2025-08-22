
#  AWS EC2 Automation Script

This project provides a **Bash script** to install and configure the AWS CLI, create an 
**Ubuntu EC2 instance** inside the **default VPC**, and handle errors gracefully.  
It also supports deleting all created resources (instance, key pair, and security group).

## 📌 Features
- Installs and configures **AWS CLI**
- Creates a **key pair** (saved locally as `.pem`)
- Creates a **security group** with SSH access
- Launches an **Ubuntu EC2 instance** in the default VPC
- Error handling at each step
- Cleanup commands to delete resources

---

##  Prerequisites
- Linux / macOS with **Bash**
- Installed `curl`, `unzip`, `awscli`, and `jq`
- An **AWS account** with proper IAM permissions
- Configured AWS credentials (via `aws configure`)

---

##  Usage

### 1. Clone the repo
```bash
git clone https://github.com/<your-username>/aws-ec2-script.git
cd EC2-AWS-CLI
````

### 2. Make the script executable

```bash
chmod +x aws-ec2.sh
```

### 3. Run the script

```bash
./aws-ec2.sh
```

It will:

* Install AWS CLI (if missing)
* Create a key pair
* Create a security group
* Launch an Ubuntu EC2 instance
* Print **Instance ID, Public IP, Key Name, and Security Group ID**

---

##  Cleanup

To delete all resources created by the script, run these commands manually:

```bash
# Terminate EC2 instance
aws ec2 terminate-instances --instance-ids <INSTANCE_ID>
aws ec2 wait instance-terminated --instance-ids <INSTANCE_ID>

# Delete Security Group
aws ec2 delete-security-group --group-id <SG_ID>

# Delete Key Pair
aws ec2 delete-key-pair --key-name <KEY_NAME>
rm -f <KEY_NAME>.pem
```

