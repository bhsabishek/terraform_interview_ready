Day 8 — Level 1
Project: Customer Portal Platform
Difficulty: ⭐ Level 1/10
Today's Topic: IAM Module + EC2 Instance Profile + Least Privilege Access
Estimated Time: 3–4 Hours
Real-World Scenario
Your infrastructure now includes:
✅ VPC
✅ Public & Private Subnets
✅ Internet Gateway
✅ NAT Gateway
✅ Route Tables
✅ Security Groups
✅ EC2 Module
✅ Application Load Balancer
✅ Auto Scaling Group
The application team now needs the EC2 instances to:
Read application files from an S3 bucket (to be created later)
Publish logs to CloudWatch
Retrieve secrets from AWS Systems Manager Parameter Store
The Security Team has rejected the proposal to use AWS Access Keys stored on the EC2 instances.
Their requirement is:
Every EC2 instance must authenticate using an IAM Role with least privilege.
Your task is to build a reusable IAM module.
Business Requirements
Create a reusable module:
modules/
    iam/
This module should be reusable for:
EC2
Lambda
ECS
EKS worker nodes (future)
CI/CD pipelines (future)
Architecture
                EC2 Instance
                     │
           IAM Instance Profile
                     │
                IAM Role
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
 CloudWatch      SSM Parameter     S3
Functional Requirements
Step 1
Create the module structure.
modules/
└── iam/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── versions.tf
Step 2
The module must create:
IAM Role
IAM Policy
IAM Role Policy Attachment
IAM Instance Profile
Step 3
Create an IAM Role for EC2.
Use the correct trust relationship so only EC2 can assume the role.
Step 4
Create a custom IAM Policy.
Grant only these permissions:
CloudWatch Logs
Create log stream
Put log events
SSM Parameter Store
GetParameter
GetParameters
S3
GetObject
Scope permissions as narrowly as practical. Avoid "*" for resources unless absolutely required for the exercise.
Step 5
Create an Instance Profile.
Your EC2 module should consume the Instance Profile instead of using static AWS credentials.
Step 6
Update your EC2/ASG module so instances launch with the IAM Instance Profile attached.
Step 7
Apply standard tags where supported.
Project

Environment

ManagedBy = Terraform

Name
Variables
Your module should accept:
project_name

environment

role_name

policy_name

s3_bucket_arn

parameter_store_path
Design the module so it can be reused for future workloads.
Outputs
Return:
IAM Role Name

IAM Role ARN

Policy ARN

Instance Profile Name
Constraints
❌ No AWS Access Keys.
❌ No AdministratorAccess policy.
❌ No wildcard "Action": "*" permissions.
❌ No provider block inside the module.
❌ No hardcoded resource names.
❌ Do not embed IAM logic inside the EC2 module.
Expected Folder Structure
terraform-enterprise-platform/

modules/
├── vpc/
├── security-group/
├── ec2/
├── alb/
├── asg/
└── iam/
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
If you're deploying to AWS:
terraform apply
Verify:
EC2 instances have the IAM Role attached.
No access keys exist on the instance.
The role appears under the EC2 instance details.
The instance can retrieve a test parameter (once created later).
Deliverables
Submit:
Updated folder structure.
All new and modified .tf files.
Output of:
terraform fmt
terraform validate
terraform plan
If applied:
IAM Role ARN
Instance Profile Name
Screenshot or output showing the role attached to an EC2 instance
What You'll Learn Today
After completing this challenge, you'll understand:
Why IAM Roles are preferred over access keys.
How Instance Profiles work.
The principle of least privilege.
How to separate IAM concerns into a reusable Terraform module.
How modules integrate cleanly without becoming tightly coupled.
Senior Code Review Checklist
When you submit your solution, I'll review it for:
IAM security best practices
Least-privilege policy design
Module reusability
Variable and output design
Naming conventions
Terraform code quality
Production readiness
Interview readinessß