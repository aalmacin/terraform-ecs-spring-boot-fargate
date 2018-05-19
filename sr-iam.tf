data "template_file" "iamHostRolePolicy" {
	template = "${file("./policies/iamHostRolePolicy.json")}"
}

data "template_file" "iamServiceRolePolicy" {
	template = "${file("./policies/iamServiceRolePolicy.json")}"
}

data "template_file" "iamInstanceRolePolicy" {
	template = "${file("./policies/iamInstanceRolePolicy.json")}"
}

resource "aws_iam_role_policy" "ecsInstanceRolePolicy" {
  name = "ecsExecutionPolicy"
  role = "${aws_iam_role.executionServiceRole.id}"

  policy = "${data.template_file.iamInstanceRolePolicy.rendered}"
}

resource "aws_iam_role" "executionRole" {
  name = "ecsExecutionRole"

  assume_role_policy = "${data.template_file.iamHostRolePolicy.rendered}"
}

resource "aws_iam_role" "executionServiceRole" {
  name = "ecsExecutionServiceRole"

  assume_role_policy = "${data.template_file.iamServiceRolePolicy.rendered}"
}

