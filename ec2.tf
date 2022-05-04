

resource "aws_instance" "myec2" {
   ami = "ami-0619177a5b68d29e3"
   instance_type = lookup(var.instancetype,terraform.workspace)
}
