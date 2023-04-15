provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAWYYXEWHSXZS5XDRL"
  secret_key = "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"
}


resource "aws_security_group" "mysg" {
  name_prefix = "finance-me-sg"
  vpc_id      = "vpc-037232b62dfa10afc"
  description = "Example security group"
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "example-security-group"
  }
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "my-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuq5Jx7Qeqa3mXGKFO5BjyT80XVQ+fpC3hb+9Fdy7X/SpjOTE2XqVXbAveCb6k4Vq2odeBrPMN/d20ZNWp2xUewz+b3l2DY1HTb1ArA36hR7cadz76si1I2f39XBL514mA0RvOBZRkzLj8LwxobwpwUkEq+XLvbI0oMQ7nzPDwHFGtYzpW72U0r6fyP9wCmdZEZ3ooej3WmDlA7tiQKiPVCWtJqCrX90yC2U3Bm5lesgtY9v7ubOZL6sktGbEBdTF6KYS0KH4vF8lrN+2F1zGp0F2XoJEBD9WSri+OZOo9a4Vax7RqfXCCVZNG0QLxMH9mjDC9r/wzqLZ51FRNIKscxoCKV+FiFsTkQGIpxcWfEs+l68wCtiHF8h6DKxv/T5P00H8lURQhwel4ntVBy2IXnAGVa9QonI8Q56lJlVRoblZVwOrXUsyznVFge9u7H47zI+ZZnMJH05nCiJiRr2PLsIDukPZ8Kdn44m/BWuIutdvR8NvTD/JJMeynRupbxus= kusha@Kushal"
}

resource "aws_instance" "FinanceMeDeploy" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykeypair.key_name
  vpc_security_group_ids = [aws_security_group.mysg.id]
  tags = {
    Name = "FinanceMEDeploy"
  }

connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("mykey")
    host        = aws_instance.FinanceMeDeploy.public_ip
  }
  
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.public_ip}' Ubuntu-config.yml"
  }
}
