Day 7 — Level 1
Project: Customer Portal Platform
Today's Topic: Auto Scaling Group (ASG) + Launch Template
Difficulty: ⭐ Level 1/10
Estimated Time: 3–4 Hours
Real-World Scenario
Your Customer Portal is now accessible through an Application Load Balancer.
However, there is a problem.
Currently, only one EC2 instance serves all user requests.
If that instance:
crashes,
is terminated accidentally,
or becomes unhealthy,
the application becomes unavailable.
The Operations Team has requested a self-healing infrastructure that automatically replaces failed instances and scales when needed.
Existing Infrastructure
You already have:
✅ VPC
✅ Public & Private Subnets
✅ Internet Gateway
✅ NAT Gateway
✅ Route Tables
✅ Security Group Module
✅ EC2 Module
✅ Application Load Balancer
✅ Target Group
Today's Goal
Create a reusable module:
modules/
    asg/
The module should provision:
Launch Template
Auto Scaling Group
Architecture
                 Internet
                     │
                    ALB
                     │
               Target Group
                     │
          ┌──────────┴──────────┐
          │                     │
      EC2 Instance         EC2 Instance
          │                     │
          └──────────┬──────────┘
                     │
             Auto Scaling Group
                     │
             Launch Template
Functional Requirements
Step 1
Create:
modules/asg/

main.tf

variables.tf

outputs.tf

versions.tf
Step 2
Create a Launch Template.
Inputs:
ami_id

instance_type

security_group_ids

user_data

key_name

iam_instance_profile

project_name

environment
Do not hardcode any values.
Step 3
Create an Auto Scaling Group.
Requirements:
Minimum: 2
Desired: 2
Maximum: 4
Deploy instances only in private subnets.
Step 4
Attach the ASG to the existing Target Group created by your ALB module.
Do not register individual instances manually anymore.
Step 5
Configure a health check.
Requirements:
Health Check Type: ELB
Grace Period: 300 seconds
Step 6
Tag instances through the Auto Scaling Group.
Every EC2 launched by the ASG should receive:
Project

Environment

ManagedBy = Terraform

Name
Ensure tags propagate to launched instances.
Step 7
Update your environment configuration.
The environment should instantiate the ASG module using outputs from:
VPC module
Security Group module
ALB module
Avoid hardcoding IDs.
Outputs
Return:
Auto Scaling Group Name

Launch Template ID

Launch Template Latest Version

Auto Scaling Group ARN
Constraints
❌ Do not launch EC2 instances directly for the application tier.
❌ Do not hardcode subnet IDs or Target Group ARNs.
❌ Do not duplicate launch template resources.
❌ Do not configure scaling policies yet (that will come later).
❌ Do not expose application instances with public IPs.
Validation
Run:
terraform fmt

terraform validate

terraform plan
If using AWS:
terraform apply
Verify:
Two EC2 instances are launched automatically.
Both instances register as healthy in the Target Group.
Terminating one instance causes the ASG to launch a replacement.
The ALB continues serving traffic.
Deliverables
Submit:
Updated folder structure.
All new and modified .tf files.
Output of:
terraform fmt
terraform validate
terraform plan
If applied:
ASG name
Launch Template ID
Target Group health status
Evidence that instance replacement works
Concepts You'll Learn
After today's challenge, you'll understand:
Why Launch Templates replace standalone EC2 instances in production.
How Auto Scaling Groups provide self-healing infrastructure.
How ASGs integrate with Target Groups.
Why application instances should be treated as immutable rather than manually managed.
Senior Code Review Checklist
I'll review your implementation for:
Module reusability
Correct Launch Template design
Proper ASG configuration
Dependency management between modules
Variable and output quality
AWS best practices
Terraform code quality
Production readiness