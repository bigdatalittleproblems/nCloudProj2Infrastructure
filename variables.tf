variable "cidr" {
  default = "10.0.0.0/16"
}
variable "name" {
  default = "Terraform"
}
variable "no_of_azs" {
  default = 3
}
locals {
  count = var.no_of_azs == 0 ? length(data.aws_availability_zones.available.names) : var.no_of_azs
}
variable "region" {
  type = string
}
variable "profile" {
  type = string
}
