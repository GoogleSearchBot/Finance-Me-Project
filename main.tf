provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAWYYXEWHS37OKFYU2"
  secret_key = "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"
}

resource "aws_instance" "FinanceMeDeploy" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = "Kushal"
  vpc_security_group_ids = ["sg-0906b8b9eb805dc82"]
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
