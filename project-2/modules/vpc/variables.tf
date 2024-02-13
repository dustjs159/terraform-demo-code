variable "vpc_cidr" {
  type        = string
  default     = "192.168.0.0/16"
}

variable "azs" {
  type        = list
  default = [ "ap-northeast-2a", "ap-northeast-2c" ]
}
