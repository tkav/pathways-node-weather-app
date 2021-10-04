variable "bucket" {
  type        = string
  description = "Specifies the name of an S3 Bucket"
  default     = "tkav-pathways-dojo"
}

variable "tags" {
  type        = map(string)
  description = "Use tags to identify project resources"
  default     = {
    Owner   = "Tom Kavanagh"
    Project = "Pathways Dojo Weather App"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/28",
    "10.0.2.0/28",
    "10.0.3.0/28",
    "10.0.4.0/28",
    "10.0.5.0/28",
    "10.0.6.0/28",
    "10.0.7.0/28",
    "10.0.8.0/28"
  ]
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets"
  type        = list(string)
  default = [
    "10.0.101.0/26",
    "10.0.102.0/26",
    "10.0.103.0/26",
    "10.0.104.0/26",
    "10.0.105.0/26",
    "10.0.106.0/26",
    "10.0.107.0/26",
    "10.0.108.0/26"
  ]
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 3
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 3
}