variable "vpc_cidr" {
    type = string
    default = ""
}

variable "tenancy" {
    type = string
    default = ""
  
}

 variable "tags" {
    type = map(string)
    default = {}
}

variable "Project_name" {
  type = string
  default = ""
}

variable "Environment" {
    type = string
    default = ""
  
}

variable "igw_tags" {
    type = map(string)
    default = {}
}
variable "public_subnet_cidrs" {
    type = list(string)
}
variable "subnet_tags" {
    type = map(string)
    default = {}
}

variable "private_subnet_cidrs" {
    type = list(string)
}

variable "public_rt_tags" {
    type = map(string)
    default = {}
}

variable "private_rt_tags" {
    type = map(string)
    default = {}
}
variable "nat_gateway_tags" {
    type = map(string)
    default = {}
}

variable "eip_tags" {
    type = map(string)
    default = {}
  
}