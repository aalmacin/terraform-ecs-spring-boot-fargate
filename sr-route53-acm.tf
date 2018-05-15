resource "aws_acm_certificate" "spacedRepetitionCert" {
  domain_name = "spaced-repetition.raidrin.com"
  validation_method = "DNS"
  tags {
    Environment = "production"
  }
}

resource "aws_route53_zone" "spacedRepetitionPublicZone" {
  name = "spaced-repetition.raidrin.com"
}

resource "aws_route53_record" "certificateRoute53Validation" {
	name = "${aws_acm_certificate.spacedRepetitionCert.domain_validation_options.0.resource_record_name}"
	type = "${aws_acm_certificate.spacedRepetitionCert.domain_validation_options.0.resource_record_type}"
	zone_id = "${aws_route53_zone.spacedRepetitionPublicZone.id}"
	records = ["${aws_acm_certificate.spacedRepetitionCert.domain_validation_options.0.resource_record_value}"]
	ttl = 60
}

resource "aws_acm_certificate_validation" "certificateValidation" {
	certificate_arn = "${aws_acm_certificate.spacedRepetitionCert.arn}"
	validation_record_fqdns = ["${aws_route53_record.certificateRoute53Validation.fqdn}"]
}

