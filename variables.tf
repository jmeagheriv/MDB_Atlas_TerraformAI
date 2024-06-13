variable "public_key" {
  description = "The public API key for MongoDB Atlas"
  type        = string
}
variable "private_key" {
  description = "The private API key for MongoDB Atlas"
  type        = string
}
variable "project_id" {
  description = "Atlas project ID"
  type        = string
}
variable "access_key" {
  description = "The access key for AWS Account"
  type        = string
}
variable "secret_key" {
  description = "The secret key for AWS Account"
  type        = string
}
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default="us-east-1"
}

variable "datadog_region" {
  description = "Datadog region"
  default     = "US"
  type        = string
}
variable "datadog_api_key" {
  description = "Datadog api key"
  type        = string
}
