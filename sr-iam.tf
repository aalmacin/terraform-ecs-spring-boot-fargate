data "template_file" "iamHostRolePolicy" {
	template = "${file("./policies/iamHostRolePolicy.json")}"
}

resource "aws_iam_role" "executionRole" {
  name = "ecsExecutionRole"

  assume_role_policy = "${data.template_file.iamHostRolePolicy.rendered}"
}

resource "aws_iam_service_linked_role" "executionServiceRole" {
  aws_service_name = "ecs.amazonaws.com"
}
