variable "aws_region" {
  type        = string
  description = "Deploy AWS"
  default     = "eu-west-1"
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile to use to execute the commands"
  default     = "default"
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"
  default     = "dev"
}
variable "bucket-name" {
  default = "bucket-site-reactaws00101"
}