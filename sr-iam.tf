
resource "aws_iam_role_policy" "ecsExecutionRole" {
  name = "ecsExecution"
  role = "${aws_iam_role.executionRole.id}"

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
			{
					"Effect": "Allow",
					"Action": [
							"ec2:AttachNetworkInterface",
							"ec2:CreateNetworkInterface",
							"ec2:CreateNetworkInterfacePermission",
							"ec2:DeleteNetworkInterface",
							"ec2:DeleteNetworkInterfacePermission",
							"ec2:Describe*",
							"ec2:DetachNetworkInterface",
							"elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
							"elasticloadbalancing:DeregisterTargets",
							"elasticloadbalancing:Describe*",
							"elasticloadbalancing:RegisterInstancesWithLoadBalancer",
							"elasticloadbalancing:RegisterTargets",
							"route53:ChangeResourceRecordSets",
							"route53:CreateHealthCheck",
							"route53:DeleteHealthCheck",
							"route53:Get*",
							"route53:List*",
							"route53:UpdateHealthCheck",
							"servicediscovery:DeregisterInstance",
							"servicediscovery:Get*",
							"servicediscovery:List*",
							"servicediscovery:RegisterInstance",
							"servicediscovery:UpdateInstanceCustomHealthStatus"
					],
					"Resource": "*"
			}
	]
}
EOF
}

resource "aws_iam_role" "executionRole" {
  name = "ecsExecutionRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

