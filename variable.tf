
variable "instancetype" {
  type = map
  default = {
    default = "t2.nano"
    dev = "t2.micro"
    prd = "t2.large"
  }
}
