variable "region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name, used as a prefix for resource names"
  type        = string
  default     = "pravinmishradmi"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "domain_name" {
  description = "Custom domain name for the site (leave empty to use the default CloudFront domain)"
  type        = string
  default     = ""
}
