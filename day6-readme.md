Day 6 — Level 1
Project: Customer Portal Platform
Today's Topic: Application Load Balancer (ALB) Module + Target Group
Difficulty: ⭐ Level 1/10
Estimated Time: 3–4 Hours
Real-World Scenario
Your infrastructure currently consists of:
✅ VPC
✅ Public & Private Subnets
✅ Internet Gateway
✅ NAT Gateway
✅ Route Tables
✅ Security Group Module
✅ EC2 Module (Bastion + Application Server)
The application team has deployed the first version of the Customer Portal. Users should never access the application EC2 instances directly. Instead, all HTTP traffic must flow through an Application Load Balancer (ALB).
Your task is to create a reusable ALB module.
Existing Architecture
Internet

   |

Application Load Balancer

   |

Target Group

   |

Application EC2 (Private Subnet)
Objective
Create a reusable module:
modules/
    alb/
This module should be reusable for future applications without code changes.
Functional Requirements
Step 1
Create the module structure.
modules/alb/

main.tf

variables.tf

outputs.tf

versions.tf
Step 2
The module must create:
One Application Load Balancer
One Target Group
One HTTP Listener (Port 80)
Do not configure HTTPS yet.
Step 3
The ALB must:
Be internet-facing
Be deployed across both public subnets
Use the ALB Security Group
Support deletion protection through a variable
Step 4
Create a Target Group.
Requirements:
Protocol: HTTP
Port: 80
Target Type: Instance
Health Check Path:
/
Health Check Settings:
Healthy Threshold: 3

Unhealthy Threshold: 3

Interval: 30 seconds
Step 5
Create a Listener.
Port 80

↓

Forward

↓

Target Group
Step 6
Register your existing Application EC2 instance with the Target Group.
Do this using Terraform.
Step 7
Variables
Your module should accept:
project_name

environment

vpc_id

public_subnet_ids

security_group_ids

enable_deletion_protection

target_instance_ids
Avoid hardcoding any values.
Step 8
Outputs
Return:
ALB ARN

ALB DNS Name

Target Group ARN

Listener ARN
Security Requirements
ALB Security Group:
Allow HTTP (80) from 0.0.0.0/0
Outbound: All traffic
Application Security Group:
Allow HTTP (80) only from the ALB Security Group
Remove any rule that allows unrestricted HTTP access.
Constraints
❌ Do not hardcode subnet IDs.
❌ Do not hardcode instance IDs.
❌ Do not create duplicate resources.
❌ Do not place the ALB in private subnets.
❌ Do not configure HTTPS or certificates yet.
❌ Do not create Auto Scaling Groups yet.
Expected Folder Structure
terraform-enterprise-platform/

modules/
├── vpc/
├── security-group/
├── ec2/
└── alb/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── versions.tf

environments/
└── dev/
    ├── main.tf
    ├── provider.tf
    ├── terraform.tfvars
    └── versions.tf
Validation
Run:
terraform fmt

terraform validate

terraform plan
If you have an AWS account:
terraform apply
Then verify:
ALB is deployed in both public subnets.
Health checks pass.
The ALB DNS name serves your application (or at least reaches the target if a web server is running).
The application instance is not directly exposed to the internet.
Deliverables
Submit:
Updated folder structure.
All new and modified .tf files.
Output of:
terraform fmt
terraform validate
terraform plan
If applied:
ALB DNS Name
Target Group status
Listener details
Health check status
Concepts You'll Learn
After completing today's challenge, you'll understand:
How an Application Load Balancer routes traffic.
The relationship between ALBs, Listeners, and Target Groups.
Why application instances should remain private.
How to build another reusable Terraform module that integrates with your existing infrastructure.
Senior Code Review Focus
I'll review your submission for:
Module design and reusability
Correct ALB architecture
Security Group implementation
Variable and output quality
Dependency handling
Naming and tagging standards
Production-readiness
Terraform best practices
Progress Tracker
✅ Day 1: Reusable VPC Module
✅ Day 2: Public & Private Subnets
✅ Day 3: Internet Gateway + NAT Gateway + Route Tables
✅ Day 4: Reusable Security Group Module
✅ Day 5: Reusable EC2 Module (Bastion + App Server)
✅ Day 6: Reusable ALB Module + Target Group (Today)
This continues building your enterprise Terraform repository one production-grade component at a time, preparing you for higher levels where we'll introduce Auto Scaling, RDS, HCP Terraform, CI/CD, Kubernetes, policy as code, and multi-cloud architectures.