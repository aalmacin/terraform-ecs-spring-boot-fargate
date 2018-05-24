resource "aws_vpc" "spacedRepetition" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Spaced Repetition"
  }
}

resource "aws_internet_gateway" "internetGateway" {
  vpc_id = "${aws_vpc.spacedRepetition.id}"

  tags {
    Name = "main"
  }
}

resource "aws_subnet" "spacedRepetitionSubnet2" {
  vpc_id = "${aws_vpc.spacedRepetition.id}"
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"

  tags {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "spacedRepetitionSubnet" {
  vpc_id = "${aws_vpc.spacedRepetition.id}"
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "Public Subnet"
  }
}

resource "aws_security_group" "spacedRepetitionPublic" {
  name = "Public"
  description = "Allow inbound traffic"
  vpc_id = "${aws_vpc.spacedRepetition.id}"

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
