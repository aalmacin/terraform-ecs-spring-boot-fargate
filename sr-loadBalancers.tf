resource "aws_lb" "spacedRepetitionLoadBalancer" {
  name               = "spacedRepetition"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.spacedRepetitionPublic.id}"]
  subnets            = ["${aws_subnet.spacedRepetitionSubnet.id}", "${aws_subnet.spacedRepetitionSubnet2.id}"]

  enable_deletion_protection = true

  tags {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "springBootContainer" {
  port = 8080
  protocol = "HTTP"
  vpc_id = "${aws_vpc.spacedRepetition.id}"
  target_type = "ip"
}

resource "aws_lb_listener" "spacedRepetitionSiteHttpListener" {
  load_balancer_arn = "${aws_lb.spacedRepetitionLoadBalancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.springBootContainer.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "spacedRepetitionSiteHttpsListener" {
  load_balancer_arn = "${aws_lb.spacedRepetitionLoadBalancer.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${aws_acm_certificate_validation.certificateValidation.certificate_arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.springBootContainer.arn}"
    type             = "forward"
  }
}
