variable "subnet_suffix" {
  description = "Suffix appended to subnet names"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "aws_region" {
    description = "AWS Region"
    default = ""
}

variable "project_prefix" {
    description = "Project prefix to be used with component names"
    default = ""
}

variable "vpc_cidr_block" {
    description = "CIDR block for VPC"
    default = ""
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 1
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 1
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/28"]
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/26"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc_cidr_block}"
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_prefix}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_prefix}-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = var.public_subnet_count
  cidr_block        = "${var.public_subnet_cidr_blocks[count.index]}"
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_prefix}-public-${var.subnet_suffix[count.index]}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = var.private_subnet_count
  cidr_block        = "${var.private_subnet_cidr_blocks[count.index]}"
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_prefix}-private-${var.subnet_suffix[count.index]}"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_prefix}-public-%"
  }
}

resource "aws_eip" "vpc_eip" {
  vpc    = true
  count  = var.public_subnet_count

  tags = {
    Name = "${var.project_prefix}-eip-${count.index}"
  }

}

data "aws_eip" "by_tags" {
  tags = {
    Name = "${var.project_prefix}-eip-%"
  }
}

resource "aws_nat_gateway" "natgw" {
  count         = var.public_subnet_count
  allocation_id = data.aws_eip.by_tags.id[count.index]
  subnet_id     = data.aws_subnet_ids.public.ids[count.index]

  tags = {
    Name = "${var.project_prefix}-nat-gw-${count.index}"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id        = aws_vpc.vpc.id
  service_name  = "com.amazonaws.${var.aws_region}.s3"
}