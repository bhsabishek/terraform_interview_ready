Day 11 — Level 1
Project: Customer Portal Platform
Difficulty: ⭐ Level 1/10
Today's Topic: Reusable RDS Module (MySQL) + Secure Networking
Estimated Time: 3–4 Hours
Business Scenario
The application is currently running behind an ALB and Auto Scaling Group.
The development team now needs a managed relational database for storing customer information. Company security standards require:
The database must never be publicly accessible.
Only application servers should be able to connect to it.
Database credentials must not be hardcoded in Terraform code.
Your task is to build a reusable RDS module that can later support multiple environments.
Existing Infrastructure
You already have:
✅ VPC
✅ Public & Private Subnets
✅ Internet Gateway
✅ NAT Gateway
✅ Route Tables
✅ Security Group Module
✅ EC2 Module
✅ ALB Module
✅ Auto Scaling Group Module
✅ IAM Module
✅ Remote State (S3 + DynamoDB)
Objective
Create a reusable module:
modules/
    rds/
This module should provision a production-style RDS instance for the application.
Architecture
                  ALB
                   │
            Auto Scaling Group
                   │
          Application EC2 Instances
                   │
        Application Security Group
                   │
           RDS Security Group
                   │
          MySQL RDS Instance
          (Private Subnets Only)
Functional Requirements
Step 1
Create the module structure.
modules/
└── rds/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── versions.tf
Step 2
Create an RDS Subnet Group using only the private subnets.
Step 3
Provision a MySQL RDS instance.
Requirements:
Engine: MySQL
DB Instance Class: db.t3.micro
Allocated Storage: 20 GB
Storage Type: gp3
Multi-AZ: Disabled (Dev environment)
Publicly Accessible: false
Deletion Protection: Configurable using a variable
Step 4
Create an RDS Security Group.
Allow inbound MySQL traffic (3306) only from the Application Security Group.
Do not allow access from:
0.0.0.0/0
Step 5
Module Variables
Accept:
project_name

environment

private_subnet_ids

vpc_id

db_name

db_username

db_password

instance_class

allocated_storage

deletion_protection
Design the module so it can be reused for PostgreSQL in the future with minimal changes.
Step 6
Outputs
Return:
RDS Endpoint

RDS ARN

Database Name

Subnet Group Name

Security Group ID
Do not output the password.
Constraints
❌ No public database.
❌ No hardcoded passwords in module code.
❌ No use of public subnets.
❌ No duplicate security groups.
❌ No provider block inside the module.
❌ Do not create read replicas yet.
Validation
Run:
terraform fmt

terraform validate

terraform plan
If deploying to AWS:
terraform apply
Verify:
The RDS instance is deployed only in private subnets.
It has no public endpoint.
The security group permits connections only from the application tier.
Deliverables
Submit:
Updated folder structure.
All new and modified .tf files.
Output of:
terraform fmt
terraform validate
terraform plan
If applied:
RDS endpoint
Security Group configuration
RDS subnet group details
Interview Discussion Points
Be prepared to answer:
Why should an RDS instance never be placed in a public subnet?
Why is an RDS Subnet Group required?
Why is allowing 0.0.0.0/0 on port 3306 considered a critical security risk?
Why should database passwords never be hardcoded in Terraform?
What changes would you make to this design for a production, highly available deployment?
What is the difference between Single-AZ and Multi-AZ deployments, and when would you choose each?
Senior Code Review Checklist
When you submit your solution, I'll review it for:
Module reusability
Security best practices
Variable design
Network isolation
Proper outputs
Naming and tagging consistency
Terraform best practices
Production readiness