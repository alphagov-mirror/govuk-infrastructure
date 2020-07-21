data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  iam_instance_profile = "GOVUK_SSM_EC2_Admin"

  subnet_id = var.private_subnet

  vpc_security_group_ids = [var.govuk_management_access_security_group]

  user_data = file("${path.module}/userdata")

  tags = {
    Name = "AdminMachine"
  }
}
