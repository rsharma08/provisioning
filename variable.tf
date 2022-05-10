
variable "instancetype" {
  type = map
  default = {
    default = "t2.nano"
    dev = "t2.micro"
    prd = "t2.large"
  }
}

variable "chef_server_url" {
    description = "Chef Server URL"
    default = "https://api.chef.io/organizations/rsharma"
}

variable "chef_user_key" {
    description = "Path to Chef user .pem"
    default = "./chef.pem"
}

variable "chef_user_name" {
    description = "Name of Chef user"
    default = "rsharma"
}

variable "chef_node_name" {
    description = "Name for node instance"
    default = "test.com"
}

variable "chef_policy_group" {
    description = "Policy Group for the node"
}

variable "chef_policy_name" {
    description = "Policy Name for the node"
}
