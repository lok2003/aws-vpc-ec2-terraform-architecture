variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "vpc_tags" {
  type    = string
  default = "VPC-ID"
}
variable "public_subnet" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))

}

variable "private_subnet" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))

}

variable "web_security_group" {
  type = object({
    name = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      cidr_ipv4   = string
      ip_protocol = string
    }))
  })
}

variable "key_pair_info" {
  type = object({
    key_pair_name   = string
    public_key_path = optional(string, "~/.ssh/id_ed25519.pub")
  })
}

variable "web_server_info" {
  type = object({
    instance_type = string
    ami_id        = string
  })
}