
variable "elb_name" {
  type = string
}

variable "az" {
  type = list(any)
}
variable "timeout" {
  type = number
}

variable "instancetype" {
  type = map
  default = {
    default = "t2.nano"
    dev = "t2.micro"
    prd = "t2.large"
  }
}
