data "template_file" "containers" {
  template = "${file("${path.module}/appContainerDefinitions.json")}"

  vars {
    "springBootECR" = "${aws_ecr_repository.springBootECR.repository_url}"
    "springBootMysqlECR" = "${aws_ecr_repository.mysqlECR.repository_url}"
    "repositoryName" = "${var.repoName}"
  }
}

data "template_file" "ecrPolicy" {
  template = "${file("${path.module}/policies/ecrPolicy.json")}"
}

resource "aws_ecs_cluster" "appECSCluster" {
  name = "${var.appName}"
}

resource "aws_ecs_service" "appECSService" {
  name = "${var.appName}"
  task_definition = "${aws_ecs_task_definition.appECSTaskDefinition.arn}"
  desired_count = 1
  health_check_grace_period_seconds=300
  cluster = "${aws_ecs_cluster.appECSCluster.arn}"

  load_balancer = {
    target_group_arn = "${aws_lb_target_group.springBootContainer.arn}"
    container_name = "${var.repoName}-spring-boot"
    container_port = 8080
  }

  launch_type = "FARGATE"
  network_configuration = [
    {
      subnets = [
        "${aws_subnet.spacedRepetitionSubnet.id}",
        "${aws_subnet.spacedRepetitionSubnet2.id}"
      ]
    }
	]

  depends_on = [
    "aws_lb_listener.appHttpListener",
    "aws_lb_listener.appHttpsListener"
  ]
}

resource "aws_ecs_task_definition" "appECSTaskDefinition" {
  family = "${var.appName}"
  container_definitions = "${data.template_file.containers.rendered}"
  network_mode = "awsvpc"
  execution_role_arn = "${aws_iam_role.executionRole.arn}"
  cpu = 1024
  memory = 2048
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecr_repository" "springBootECR" {
  name = "${var.repoName}-spring-boot"
}

resource "aws_ecr_repository" "mysqlECR" {
  name = "${var.repoName}-mysql"
}

resource "aws_ecr_repository_policy" "appECRPolicy" {
  repository = "${aws_ecr_repository.springBootECR.name}"

  policy = "${data.template_file.ecrPolicy.rendered}"
}

resource "aws_ecr_repository_policy" "appMysqlECRPolicy" {
  repository = "${aws_ecr_repository.mysqlECR.name}"

  policy = "${data.template_file.ecrPolicy.rendered}"
}

output "ecr-spring-boot" {
  value = "${aws_ecr_repository.springBootECR.repository_url}"
}

output "ecr-mysql" {
  value = "${aws_ecr_repository.mysqlECR.repository_url}"
}
