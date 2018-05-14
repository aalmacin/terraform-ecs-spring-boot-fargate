resource "aws_vpc" "spacedRepetition" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Spaced Repetition"
  }
}
