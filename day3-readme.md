🚀 Terraform Bootcamp
Day 3 — Level 1
Topic: Internet Gateway + Route Tables + Public Internet Access
Estimated Time: 2–3 Hours
Real-World Scenario
The networking team has reviewed your VPC implementation.
Application teams now want to deploy an Application Load Balancer (ALB) in the public subnet.
However, your public subnets currently cannot access the Internet because there is:
❌ No Internet Gateway
❌ No Route Table
❌ No Route Table Association
Your task is to make only the public subnets internet accessible, while keeping private subnets isolated.
Existing Infrastructure
From previous days, you already have:
terraform-enterprise-platform/

modules/
    vpc/

environments/
    dev/

VPC
Public Subnets
Private Subnets
Today's Goal
Extend the existing VPC module.
Create:
Internet Gateway

↓

Public Route Table

↓

Default Route (0.0.0.0/0)

↓

Associate ONLY Public Subnets
Architecture
                 Internet

                     |

            Internet Gateway

                     |

              Public Route Table
                     |
        ----------------------------
        |                          |
 Public Subnet A            Public Subnet B

-----------------------------------------------

 Private Subnet A   (No Internet)

 Private Subnet B   (No Internet)
Requirements
Step 1
Inside your VPC module, create:
Internet Gateway
It should be attached to the VPC created by your module.
Step 2
Create a Public Route Table.
It should contain:
Destination

0.0.0.0/0

↓

Target

Internet Gateway
Step 3
Associate only the public subnets with this route table.
Use for_each.
Do not create two separate association resources.
Step 4
Private subnets should not be associated with this route table.
They should remain isolated.
(No NAT Gateway yet—we'll add that later.)
Step 5
Tag all resources.
Internet Gateway
Project

Environment

ManagedBy = Terraform

Name
Example:
customer-portal-dev-igw
Route Table
customer-portal-dev-public-rt
Variables
Do not introduce unnecessary variables today.
Reuse the variables you already created:
project_name
environment
Outputs
Add:
internet_gateway_id

public_route_table_id
Constraints
❌ Do not modify your environment structure.
❌ Do not create another module.
❌ Do not hardcode VPC IDs.
❌ Do not duplicate route table association resources.
❌ Do not create a NAT Gateway.
❌ Do not create private route tables yet.
Expected Folder Structure
terraform-enterprise-platform/

modules/
└── vpc/
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
No new folders today.
Commands to Run
terraform fmt
terraform validate
terraform plan
Do not run terraform apply yet. During the bootcamp, we'll treat terraform plan as our quality gate unless a later challenge explicitly requires deployment.
Deliverables
When you're done, send me:
The updated folder structure.
The contents of every modified .tf file.
The output of:
terraform fmt
terraform validate
terraform plan
🎯 What You'll Learn Today
After completing this challenge, you'll understand:
Why an Internet Gateway is required
How route tables control network traffic
The difference between a VPC and a route table
Why only public subnets receive a default internet route
How to use for_each for scalable route table associations
How AWS determines whether a subnet is "public" or "private"
👨‍💻 Senior Engineer Tips
While implementing, think about these questions:
Why does attaching an Internet Gateway not automatically make a subnet public?
What exactly makes a subnet "public" in AWS?
If you accidentally associate a private subnet with the public route table, what happens?
Why are route table associations often implemented with for_each instead of individual resources?
This challenge intentionally introduces one new AWS networking concept at a time. Tomorrow (Day 4), we'll continue by creating Elastic IPs, NAT Gateway, and Private Route Tables, completing a production-ready network foundation before we move on to security groups and compute resources.
