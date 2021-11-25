provider "aws"{
region= "us-east-2"
access_key="AKIAUBLGIA6ANDZTS6X5"
secret_key="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"
}
resource "aws_instance" "demo" {

 ami = "ami-0629230e074c580f2"
 instance_type = "t2.medium"
root_block_device {
       delete_on_termination = true
       encrypted             = false
       throughput            = 0
       volume_size           = 100
       volume_type           = "gp2"
      
 }


tags = {

       "Name" = "terraform.demo"
            }

     user_data = file("./install.sh")

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
