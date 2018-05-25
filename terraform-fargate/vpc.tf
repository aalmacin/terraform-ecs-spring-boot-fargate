resource "aws_vpc" "app" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.appName}"
  }
}

resource "aws_internet_gateway" "internetGateway" {
  vpc_id = "${aws_vpc.app.id}"

  tags {
    Name = "main"
  }
}

resource "aws_subnet" "appSubnet2" {
  vpc_id = "${aws_vpc.app.id}"
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"

  tags {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "appSubnet" {
  vpc_id = "${aws_vpc.app.id}"
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "Public Subnet"
  }
}

resource "aws_security_group" "appPublic" {
  name = "Public"
  description = "Allow inbound traffic"
  vpc_id = "${aws_vpc.app.id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Public Security Group"
  }
}
