
#CIDR Blocks
variable "main_vpc_cidr_block" {
  description = "CIDR block for the main environment VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet in the main environment VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet in the main environment VPC"
  type        = string
  default     = "10.0.2.0/24"
}

variable "jump_box_private_ip" {
  description = "Hard-coded IP for jump box"
  type        = string
  default     = "10.0.1.30"
}

variable "box_a_private_ip" {
  description = "Hard-coded IP for box A"
  type        = string
  default     = "10.0.2.30"
}

variable "box_b_private_ip" {
  description = "Hard-coded IP for box B"
  type        = string
  default     = "10.0.2.31"
}


