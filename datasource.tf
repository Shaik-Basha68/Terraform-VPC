 data "aws_availability_zones" "available" {
  state = "available"
} 

data "aws_vpc" "selected" {
  id="vpc-0f8264e009bd7a530"
}