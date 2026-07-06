variable "proj_name" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "policy_name" {
  description = "Policy name"
  type = string
}

variable "assume_role_policy" {
  description = "Assume Role Policy"
  type = string
}

variable "policy" {
  description = "The policy document to attach to the role"
  type        = string
}