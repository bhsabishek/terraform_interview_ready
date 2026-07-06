Day 10 — Level 1
Project: Customer Portal Platform
Difficulty: ⭐ Level 1/10
Today's Topic: Migrate Terraform State to an S3 Remote Backend with DynamoDB Locking
Estimated Time: 3–4 Hours
Business Scenario
Your platform team has approved the backend infrastructure you created yesterday:
✅ S3 Bucket
✅ DynamoDB Lock Table
Now it's time to move from local state to a shared remote backend.
This migration must be completed without recreating any infrastructure or losing Terraform state.
As the DevOps engineer, your responsibility is to migrate the state safely.
Existing Infrastructure
Your repository currently contains:
terraform-enterprise-platform/

modules/
├── vpc/
├── security-group/
├── ec2/
├── alb/
├── asg/
├── iam/
└── terraform-backend/

environments/
└── dev/
All infrastructure is currently managed using:
terraform.tfstate
stored locally.
Objective
Configure Terraform to use:
S3 Backend

↓

State Locking

↓

DynamoDB
without recreating existing AWS resources.
Functional Requirements
Step 1
Add a backend configuration.
Use:
backend "s3" {
  bucket         = "<bucket-name>"
  key            = "customer-portal/dev/terraform.tfstate"
  region         = "<aws-region>"
  dynamodb_table = "<lock-table>"
  encrypt        = true
}
Use values from your environment. Do not hardcode production values in shared modules.
Step 2
Initialize Terraform.
Run:
terraform init -migrate-state
Understand what this command does before executing it.
Step 3
Verify that:
Local state has been migrated.
State now exists in the S3 bucket.
A state lock is created in DynamoDB during Terraform operations.
Step 4
Run:
terraform plan
Expected result:
No changes.

Infrastructure is up-to-date.
No resources should be recreated.
Step 5
Demonstrate state locking.
Open two terminals.
In Terminal 1:
terraform apply
Before it finishes, in Terminal 2:
terraform plan
Observe the locking behavior.
Document what happens.
Step 6
Inspect the state.
Use:
terraform state list
and identify:
VPC
Subnets
Route Tables
NAT Gateway
Security Groups
ALB
ASG
IAM Resources
Constraints
❌ Do not delete the local state manually before migration.
❌ Do not create a new backend bucket.
❌ Do not recreate infrastructure.
❌ Do not force unlock unless you understand why the lock exists.
❌ Do not modify resource addresses in the state.
Expected Deliverables
Submit:
Updated backend configuration.
Output of:
terraform init -migrate-state
terraform plan
terraform state list
Evidence that:
State exists in S3.
Locking works with DynamoDB.
A short explanation of the migration process.
Troubleshooting Exercise
Your teammate reports:
Error acquiring the state lock
Investigate and explain:
Why the error occurs.
How to identify who holds the lock.
When it is safe to use:
terraform force-unlock
Why using force-unlock carelessly can be dangerous.
Interview Discussion Points
Be prepared to answer:
What is stored inside the Terraform state file?
Why is remote state mandatory for team environments?
Why do we use DynamoDB for locking instead of S3 alone?
What happens if the network connection is lost during terraform apply?
How would you recover from accidental state corruption?
What is the difference between terraform refresh, terraform import, and terraform state commands?
How would you migrate state between AWS accounts with minimal risk?
Validation Checklist
Your solution is complete when:
✅ Backend configuration is correct.
✅ State migration completes successfully.
✅ terraform plan shows no infrastructure changes.
✅ State locking is verified.
✅ No resources are recreated.
✅ You can explain every migration step confidently.
🎯 Learning Outcomes
After today's challenge, you'll be able to:
Configure a remote Terraform backend.
Safely migrate existing local state.
Understand how state locking prevents concurrent operations.
Inspect and troubleshoot Terraform state.
Perform one of the most common real-world Terraform operations without risking production infrastructure.