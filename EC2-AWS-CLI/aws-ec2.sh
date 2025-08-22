#!/bin/bash

# Script to install & configure AWS CLI and launch an EC2 instance in Default VPC
# Author: Hunzala Awan
# Date: $(date)

set -e  # exit on error
trap 'echo "❌ Error occurred on line $LINENO. Exiting..."; exit 1' ERR

# =============== FUNCTIONS ===============

install_aws_cli() {
    echo "🔹 Checking if AWS CLI is installed..."
    if ! command -v aws &>/dev/null; then
        echo "Installing AWS CLI..."
        sudo apt-get update -y
        sudo apt-get install unzip curl -y
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip -q awscliv2.zip
        sudo ./aws/install
        rm -rf aws awscliv2.zip
    else
        echo "✅ AWS CLI already installed"
    fi
}

configure_aws_cli() {
    echo "🔹 Configuring AWS CLI..."
    if [ ! -f ~/.aws/credentials ]; then
        aws configure
    else
        echo "✅ AWS CLI already configured."
    fi
}

create_key_pair() {
    echo "🔹 Creating EC2 Key Pair..."
    KEY_NAME="ec2-key-$(date +%s)"
    aws ec2 create-key-pair --key-name "$KEY_NAME" \
        --query 'KeyMaterial' --output text > "${KEY_NAME}.pem"

    chmod 400 "${KEY_NAME}.pem"
    echo "✅ Key pair created: $KEY_NAME"
    export KEY_NAME
}

create_security_group() {
    echo "🔹 Creating Security Group in Default VPC..."
    SG_NAME="ec2-sg-$(date +%s)"

    # Fetch default VPC ID
    VPC_ID=$(aws ec2 describe-vpcs \
        --filters "Name=isDefault,Values=true" \
        --query "Vpcs[0].VpcId" \
        --output text)

    if [ "$VPC_ID" == "None" ]; then
        echo "❌ No default VPC found. Exiting..."
        exit 1
    fi

    SG_ID=$(aws ec2 create-security-group \
        --group-name "$SG_NAME" \
        --description "Security group for EC2 instance" \
        --vpc-id "$VPC_ID" \
        --query 'GroupId' --output text)

    echo "✅ Security group created: $SG_ID"

    # Allow SSH & HTTP
    aws ec2 authorize-security-group-ingress --group-id "$SG_ID" \
        --protocol tcp --port 22 --cidr 0.0.0.0/0
    aws ec2 authorize-security-group-ingress --group-id "$SG_ID" \
        --protocol tcp --port 80 --cidr 0.0.0.0/0

    export SG_ID
}

launch_ec2_instance() {
    echo "🔹 Launching EC2 Instance..."
    INSTANCE_TYPE="t2.micro"
    AMI_ID=$(aws ec2 describe-images \
        --owners amazon \
        --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
        --query 'Images | sort_by(@,&CreationDate)[-1].ImageId' \
        --output text)

    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id "$AMI_ID" \
        --count 1 \
        --instance-type "$INSTANCE_TYPE" \
        --key-name "$KEY_NAME" \
        --security-group-ids "$SG_ID" \
        --query 'Instances[0].InstanceId' \
        --output text)

    echo "⏳ Waiting for EC2 instance to start..."
    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

    PUBLIC_IP=$(aws ec2 describe-instances \
        --instance-ids "$INSTANCE_ID" \
        --query 'Reservations[0].Instances[0].PublicIpAddress' \
        --output text)

    echo "✅ EC2 Instance launched successfully!"
    echo "   Instance ID: $INSTANCE_ID"
    echo "   Public IP: $PUBLIC_IP"
    echo "   SSH Command: ssh -i ${KEY_NAME}.pem ec2-user@${PUBLIC_IP}"
}

# =============== MAIN SCRIPT ===============

echo "🚀 Starting AWS EC2 Deployment Script (Default VPC)"

install_aws_cli
configure_aws_cli
create_key_pair
create_security_group
launch_ec2_instance

echo "🎉 Deployment Completed Successfully!"
