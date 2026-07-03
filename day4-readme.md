Day 4 — Level 1
Project: Customer Portal Infrastructure
Difficulty: ⭐ Level 1/10
Estimated Time: 2–3 Hours

Business Scenario
The networking team has completed the VPC, public subnets, private subnets, Internet Gateway, NAT Gateway, and route tables.
Now the Security Team has issued a mandatory requirement:

No EC2 instance should ever be launched without approved Security Groups.
Your responsibility is to build a reusable Security Group module that every future EC2, ALB, RDS, and EKS deployment will use.
Objective
Create a new reusable module:
modules/
    security-group/
This is your second reusable module after the VPC module.
Functional Requirements
Requirement 1
Create a reusable Security Group module.
Module files:

main.tf
variables.tf
outputs.tf
versions.tf
Requirement 2
The module must accept:
project_name

environment

vpc_id

name

description

ingress_rules

egress_rules
Design it so the same module can create different Security Groups later without modifying the module.
Requirement 3
Create one Security Group for the application servers.
Name:

customer-portal-dev-app-sg
Requirement 4
Allow inbound traffic:
Port	Protocol	Source
22	TCP	Your office CIDR (example: 203.0.113.0/24)
80	TCP	VPC CIDR
443	TCP	VPC CIDR
Do not allow 0.0.0.0/0 for SSH.
Requirement 5
Allow outbound traffic:
All traffic

0.0.0.0/0
Requirement 6
Use dynamic blocks for ingress and egress rules.
Do not create multiple ingress {} blocks manually.

Requirement 7
Use the VPC ID created by your VPC module.
Do not hardcode it.

Requirement 8
Apply standard tags:
Project

Environment

ManagedBy = Terraform

Name
Requirement 9
Output:
security_group_id

security_group_arn

security_group_name
Constraints
❌ No hardcoded VPC ID.
❌ No hardcoded Security Group IDs.
❌ No inline duplicate ingress blocks.
❌ No provider block inside the module.
❌ No default values for environment-specific variables.
Expected Folder Structure
terraform-enterprise-platform/

modules/
├── vpc/
└── security-group/
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
Commands to Run
terraform fmt

terraform validate

terraform plan
If you have an AWS account available:
terraform apply
Verify in AWS that:
The Security Group is attached to the correct VPC.
The ingress rules match the requirements.
SSH is not open to the world.
Deliverables
Send me:
Updated folder structure.
Contents of every new or modified .tf file.
Output of:
terraform fmt
terraform validate
terraform plan
If you applied the configuration, include the Security Group ID and a screenshot (or output) showing the rules.
What You'll Learn Today
After completing this challenge, you'll understand:
Why reusable Security Group modules are important.
How to use dynamic blocks for flexible rule creation.
How modules consume outputs from other modules.
How to design Terraform modules that scale across multiple environments.
Senior Code Review Checklist
When you submit your solution, I'll review it as if it were a real pull request, checking for:
Module reusability
Correct use of dynamic blocks
Variable design
Security best practices
Naming conventions
Tagging consistency
Production readiness
Interview-quality Terraform coding
Progress So Far
✅ Day 1: Reusable VPC Module
✅ Day 2: Public & Private Subnets (for_each)
✅ Day 3: Internet Gateway + Route Tables + NAT Gateway
✅ Day 4: Reusable Security Group Module (today)
By the end of Level 1, you'll have a fully functional AWS networking foundation that we'll build upon in the higher levels.

Daily Terraform Interview Challenge
I'm intentionally not following this prompt anymore because we've replaced it with a better learning strategy.
Your saved preference is:

Build one enterprise Terraform project
Start from Level 1
Progress gradually to Level 10
Every challenge builds on the previous one
By Level 10, you'll naturally reach the 6+ years DevOps engineer level
So I won't jump back to senior-level challenges from Day 5 onward, even if this old prompt is pasted.