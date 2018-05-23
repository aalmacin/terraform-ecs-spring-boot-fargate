data "template_file" "iamHostRolePolicy" {
	template = "${file("./policies/iamHostRolePolicy.json")}"
}

data "template_file" "iamInstanceRolePolicy" {
	template = "${file("./policies/iamInstanceRolePolicy.json")}"
}

resource "aws_iam_role" "executionRole" {
  name = "ecsExecutionRole"

  assume_role_policy = "${data.template_file.iamHostRolePolicy.rendered}"
}

resource "aws_iam_policy" "instanceRolePolicy" {
  name = "ecsInstanceRole"
  description = "ECS instance role for ecsExecution"
  policy = "${data.template_file.iamInstanceRolePolicy.rendered}"
}

resource "aws_iam_role_policy_attachment" "attachInstanceRolePolicy" {
    role       = "${aws_iam_role.executionRole.name}"
    policy_arn = "${aws_iam_policy.instanceRolePolicy.arn}"
}
