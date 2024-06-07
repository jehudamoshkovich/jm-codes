provider "aws" {
    region = "eu-west-2"  
}


resource "aws_security_group" "webtraffic" {
name = "Allow HTTPS1"


dynamic "ingress" {
  for_each = [80,443]
  iterator = port
  
  content {
 
  from_port = port.value
  to_port = port.value
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  }
}

dynamic "egress" {
  for_each = [25, 80,443, 8080]
  iterator = port
  
  content {
 
  from_port = port.value
  to_port = port.value
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  }
}

}


resource "aws_instance" "ec2" {
  ami = "ami-019a292cfb114a776"
instance_type = "t2.micro"
security_groups = [aws_security_group.webtraffic.name]
}
