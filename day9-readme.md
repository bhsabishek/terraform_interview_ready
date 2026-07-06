Day 9 — Level 1
Project: Customer Portal Platform
Today's Topic: S3 Backend Preparation + DynamoDB State Locking (Local First)
Difficulty: ⭐ Level 1/10
Estimated Time: 3–4 Hours
Real-World Scenario
Your Terraform codebase has grown considerably.
Your team currently runs Terraform from local laptops using the default local state:
terraform.tfstate
Last week, two engineers accidentally ran terraform apply at the same time.
Result:
State file conflicts
Drift between infrastructure and state
Manual recovery effort
The Platform Team has decided that before any more infrastructure is added, the Terraform project must be prepared for remote state management.
Today you'll build the foundation for remote state. We won't migrate state yet—that will happen in a later challenge.
Existing Infrastructure
You already have:
✅ VPC Module
✅ Public & Private Subnets
✅ Internet Gateway
✅ NAT Gateway
✅ Route Tables
✅ Security Group Module
✅ EC2 Module
✅ ALB Module
✅ Auto Scaling Group Module
✅ IAM Module
Objective
Create a reusable module:
modules/
    terraform-backend/
This module provisions the AWS resources that will later hold Terraform state.
Architecture
                Terraform

                    │

             (Future Migration)

                    │

         S3 Backend Bucket

                    │

          DynamoDB Lock Table
Functional Requirements
Step 1
Create a reusable backend module.
modules/
└── terraform-backend/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── versions.tf
Step 2
Create an S3 bucket for Terraform state.
Requirements:
Versioning enabled
Server-side encryption enabled
Block all public access
Bucket owner enforced object ownership
Appropriate tags
Step 3
Create a DynamoDB table for state locking.
Requirements:
Billing mode: PAY_PER_REQUEST
Partition key:
LockID
Type:
String
Step 4
Do not configure the Terraform backend block yet.
Continue using the local backend.
The goal today is to prepare the infrastructure only.
Step 5
Variables
Support:
project_name

environment

bucket_name

lock_table_name
Do not hardcode names inside the module.
Step 6
Outputs
Return:
Bucket Name

Bucket ARN

DynamoDB Table Name

DynamoDB Table ARN
Constraints
❌ Do not migrate state today.
❌ Do not add a backend "s3" block yet.
❌ Do not disable bucket encryption.
❌ Do not disable versioning.
❌ Do not make the bucket public.
❌ Do not use default values for environment-specific names.
Expected Folder Structure
terraform-enterprise-platform/

modules/
├── vpc/
├── security-group/
├── ec2/
├── alb/
├── asg/
├── iam/
└── terraform-backend/
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
Commands
Run:
terraform fmt

terraform validate

terraform plan
If you have an AWS account available, you may also run:
terraform apply
Verify:
The S3 bucket has versioning enabled.
Server-side encryption is enabled.
Public access is blocked.
The DynamoDB table exists with the LockID partition key.
Deliverables
Submit:
Updated folder structure.
Every new or modified .tf file.
Output of:
terraform fmt
terraform validate
terraform plan
If you applied the resources:
S3 bucket details
DynamoDB table details
AWS console screenshots (optional)
What You'll Learn Today
After completing this challenge, you'll understand:
Why local Terraform state doesn't scale to teams.
Why S3 versioning is critical for state recovery.
How DynamoDB prevents concurrent Terraform operations.
How to prepare infrastructure for remote state before migration.
Interview Discussion Points
Be prepared to answer:
Why is S3 versioning essential for Terraform state?
What problems does DynamoDB state locking solve?
Why shouldn't multiple engineers use a local state file?
Why are we creating the backend infrastructure before migrating the state?
What could happen if the state bucket were accidentally made public?
How would you recover if someone deleted the latest state file but versioning was enabled?