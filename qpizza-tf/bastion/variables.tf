variable "vpc_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "key_name" {
    type = string
    default = "tfkeypair"
}

variable "bastion_instance_type" {
    type = string
    default = "t4g.micro"
}