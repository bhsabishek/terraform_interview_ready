Day 5 — Level 1
Project: Customer Portal Platform
Today's Topic: Reusable EC2 Module + Bastion Host + Private Application Server

Difficulty: ⭐ Level 1/10

Estimated Time: 3–4 Hours

Real-World Scenario
The networking team has completed:
✅ VPC
✅ Public & Private Subnets
✅ Internet Gateway
✅ NAT Gateway
✅ Route Tables
✅ Security Group Module
Now the application team needs compute infrastructure.
Company policy states:

Production application servers must never be deployed in public subnets.
Only a Bastion Host is allowed in a public subnet for administrative access.
Existing Infrastructure
From previous challenges, you already have:
terraform-enterprise-platform/

modules/
├── vpc/
└── security-group/

environments/
└── dev/
Today's Goal
Create your third reusable module:
modules/
    ec2/
Using this single module, deploy:
Bastion Host (Public)
Application Server (Private)
Architecture
                    Internet
                        |
                  Internet Gateway
                        |
                Public Subnet
                        |
                  Bastion Host
                        |
                     SSH Only
                        |
               -----------------
               |               |
         Private Subnet   Private Subnet
               |
         Application EC2
Functional Requirements
Step 1
Create a reusable EC2 module.
Files:

main.tf

variables.tf

outputs.tf

versions.tf
Step 2
The module must support creating any EC2 instance, not just today's servers.
Inputs should include:

ami_id

instance_type

subnet_id

security_group_ids

associate_public_ip

instance_name

project_name

environment
Step 3
Deploy:
Bastion Host
Requirements:
Public subnet
Public IP enabled
Bastion Security Group
Instance Type:
t3.micro
Step 4
Deploy:
Application Server
Requirements:
Private subnet
No public IP
Application Security Group
Instance Type:
t3.micro
Step 5
Do not duplicate code.
Instantiate the EC2 module twice from the environment layer.

Step 6
Apply standard tags:
Project

Environment

ManagedBy = Terraform

Name
Examples:
customer-portal-dev-bastion

customer-portal-dev-app-01
Step 7
Outputs
The module should return:

Instance ID

Private IP

Public IP

Availability Zone

ARN
Remember that the Application Server won't have a public IP.
Constraints
❌ Do not hardcode AMI IDs inside the module.
❌ Do not hardcode subnet IDs.
❌ Do not create separate modules for Bastion and App.
❌ Do not duplicate EC2 resource blocks.
❌ Do not configure providers inside the module.
❌ Do not use default values for environment-specific settings.
Expected Folder Structure
terraform-enterprise-platform/

modules/
├── vpc/
├── security-group/
└── ec2/
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
If you're using AWS, also run:
terraform apply
Verify:
Bastion Host has a public IP.
Application Server has no public IP.
Both instances are in the expected subnets.
Tags are applied correctly.
Deliverables
Submit:
Updated folder structure.
Every new and modified .tf file.
Output of:
terraform fmt
terraform validate
terraform plan
If applied:
EC2 Instance IDs
Public/Private IPs
AWS console screenshot (optional)
Concepts You'll Learn Today
After completing this challenge, you'll understand:
How to design a reusable EC2 module.
Why infrastructure should be composed by instantiating modules, not copying resources.
The difference between Bastion Hosts and private application servers.
How networking decisions affect EC2 accessibility.
Senior Code Review Focus
When you submit your code, I'll review it like a real pull request and evaluate:
Module reusability
Variable naming
Output quality
Terraform best practices
AWS networking correctness
Code organization
Production readiness
Interview readiness
Bootcamp Progress
✅ Day 1: Reusable VPC Module
✅ Day 2: Public & Private Subnets (for_each)
✅ Day 3: Internet Gateway + NAT Gateway + Route Tables
✅ Day 4: Reusable Security Group Module
✅ Day 5: Reusable EC2 Module (Bastion + Private Application Server)
By the end of Level 1, you'll have built a complete, modular AWS foundation that we can confidently extend into ALBs, Auto Scaling, RDS, HCP Terraform, Kubernetes, and eventually the senior-level platform engineering scenarios you're aiming for.

Daily Terraform Interview Challenge
I won't use this old prompt because we've intentionally replaced it with your new learning plan.
Your saved preference is to progress from Level 1 to Level 10 through one continuous enterprise Terraform project. So instead of a 6+ years challenge today, here's the next challenge in your bootcamp.