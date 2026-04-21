# 🚀 Terraform AWS Networking Architecture

This project demonstrates how to build a **secure and scalable AWS infrastructure** using Infrastructure as Code (IaC) with Terraform.

It provisions a complete networking setup including:

* Virtual Private Cloud (VPC)
* Public and Private Subnets (Multi-AZ)
* Internet Gateway & Route Tables
* Security Groups (Firewall rules)
* EC2 Instance deployment

---

## 📌 Architecture Overview

```
                   Internet
                      │
              Internet Gateway
                      │
              Public Subnet (Web Tier)
                      │
                EC2 Instance
                      │
              Private Subnet (DB Tier)
```

* Public subnet hosts web-facing resources
* Private subnet is reserved for backend services (future: RDS)
* Security groups restrict inbound/outbound traffic

---

## 🛠️ Technologies Used

* Terraform (>= 1.5)
* AWS (VPC, EC2, Security Groups, Subnets)
* GitHub for version control

---

## 📂 Project Structure

```
.
├── network.tf        # VPC, subnets, routing, security groups
├── provider.tf       # Terraform & AWS provider configuration
├── variables.tf      # Input variable definitions
├── example.tfvars    # Variable values
├── outputs.tf        # Outputs (VPC ID, Subnets, EC2 IP)
```

---

## ⚙️ Prerequisites

* AWS Account
* AWS CLI configured (`aws configure`)
* Terraform installed
* SSH key pair (for EC2 access)

---

## 🚀 Deployment Steps

### 1. Initialize Terraform

```
terraform init
```

### 2. Validate Configuration

```
terraform validate
```

### 3. Apply Infrastructure

```
terraform apply -var-file="example.tfvars"
```

---

## 🔐 Access EC2 Instance

After deployment, Terraform outputs the public IP.

Connect using SSH:

```
ssh ubuntu@<public-ip>
```

---

## 🧹 Destroy Infrastructure

To clean up resources:

```
terraform destroy -var-file="example.tfvars"
```

---

## 🔐 Security Considerations

* Avoid using `0.0.0.0/0` for SSH (port 22) in production
* Use restricted IP ranges for secure access
* Store sensitive data using AWS Secrets Manager (future enhancement)

---



## 🎯 Key Learnings

* Designing AWS VPC architecture with public & private subnets
* Managing infrastructure using Terraform
* Implementing secure networking practices
* Automating EC2 deployment

---

## 📌 Author

**Lokesh**
Aspiring DevOps Engineer | AWS | Terraform | CI/CD

---

## ⭐ Contributing

Feel free to fork this repository and improve the architecture.

---

## 📄 License

This project is open-source and available under the MIT License.
