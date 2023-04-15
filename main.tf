provider "aws" {
  region = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "FinanceMeDeploy" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = "Kushal.pem"
  security_groups = ["sg-0906b8b9eb805dc82"]
  tags = {
    Name = "FinanceMEDeploy"
  }
}

resource "null_resource" "ansible_provisioner" {
  depends_on = [aws_instance.FinanceMeDeploy]
  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_instance.FinanceMeDeploy.public_ip},' Ubuntu-config.yml"
  }
}
