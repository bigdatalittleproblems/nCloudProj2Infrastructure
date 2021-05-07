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
variable "project" {
  default = "nCloudProject2"
}

##########################################
# variable "map_accounts" {
#   description = "Additional AWS account numbers to add to the aws-auth configmap."
#   type        = list(string)

#   default = [
#     "777777777777",
#     "888888888888",
#   ]
# }

# variable "map_roles" {
#   description = "Additional IAM roles to add to the aws-auth configmap."
#   type = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       rolearn  = "arn:aws:iam::66666666666:role/role1"
#       username = "role1"
#       groups   = ["system:masters"]
#     },
#   ]
# }

# variable "map_users" {
#   description = "Additional IAM users to add to the aws-auth configmap."
#   type = list(object({
#     userarn  = string
#     username = string
#     groups   = list(string)
#   }))

#   default = [
#     {
#       userarn  = "arn:aws:iam::66666666666:user/user1"
#       username = "user1"
#       groups   = ["system:masters"]
#     },
#     {
#       userarn  = "arn:aws:iam::66666666666:user/user2"
#       username = "user2"
#       groups   = ["system:masters"]
#     },
#   ]
# }