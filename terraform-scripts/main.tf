data "aws_vpc" "vpc" {
  tags  = {
    Name  = "interview-vpc"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id  = "${data.aws_vpc.vpc.id}"
}

data "aws_security_group" "sg" {
  vpc_id  = "${data.aws_vpc.vpc.id}"
  tags  = {
    Name  = "interview-vpc-allow-all-sg"
  }
}

resource "aws_instance" "foo-instance" {

  instance_type = "t2.nano"
  ami           = "ami-0443305dabd4be2bc"

  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = ["${data.aws_security_group.sg.id}"]
  associate_public_ip_address = true

  key_name  = "PersonalEC2Key"

  tags  = {
    Name  = "${var.instance_name}"
  }
}