variable "vpc_cidr" {
  type        = string
  description = "VPC cidr block"
  default     = "10.0.0.0/16"
}

variable "tenancy" {
  type        = string
  description = "tenancy of the vpc"
  default     = "default"

}

variable "tags" {
  type = map(string)
  default = {
    purpose    = "vpc-module-Test"
    Dontdelete = "true"
  }
}

variable "Project_name" {
  type        = string
  description = "Project name"
  default     = "Roboshop"
}

variable "Environment" {
  type        = string
  description = "Environment Name"
  default     = "Dev"

}

variable "public_subnet_cidrs" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
  
}

variable "private_subnet_cidrs" {
    type = list(string)
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}