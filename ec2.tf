
/*resource "aws_instance" "myec2" {
   ami = "ami-0619177a5b68d29e3"
   instance_type = lookup(var.instancetype,terraform.workspace)
}
*/

data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
   ami = data.aws_ami.app_ami.id
   instance_type = "t2.micro"
   key_name = "teraform"
   vpc_security_group_ids  = [aws_security_group.allow_ssh1.id]

   connection {
     type = "ssh"
     user = "ec2-user"
     private_key = file("./teraform.pem")
     host = self.public_ip
   }
   provisioner "remote-exec" {
    inline = [templatefile("chef.sh.tftpl", {
      validation_client_name = "rsharma"
      validation_key         = file("./chef.pem")
      chef_client_version    = "17.9.52"
      chef_environment       = "default"
      node_name              = "test.com"
      attributes = {
        "run_list" = [
          "recipe[base]"
        ]
      }
    })]
}
}
### NOTE - Adding a new security group resource to allow the terraform provisioner from laptop to connect to EC2 Instance via SSH.

resource "aws_security_group" "allow_ssh1" {
  name        = "allow_ssh1"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "tcp"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


/*resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
}

output "fingerprint" {
  value = aws_key_pair.ssh.fingerprint
}

output "name" {
  value = aws_key_pair.ssh.key_name
}

output "id" {
  value = aws_key_pair.ssh.id
}
*/
