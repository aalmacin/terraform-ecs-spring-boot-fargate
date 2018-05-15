data "template_file" "containers" {
  template = "${file("spacedRepetitionContainerDefinitions.json")}"

  vars {
    "springBootECR" = "${aws_ecr_repository.spacedRepetitionECR.repository_url}"
    "springBootMysqlECR" = "${aws_ecr_repository.spacedRepetitionMysqlECR.repository_url}"
  }
}

resource "aws_ecs_cluster" "spacedRepetitionECSCluster" {
  name = "SpacedRepetition"
}

resource "aws_ecs_service" "spacedRepetitionService" {
  name = "website"
  task_definition = "${aws_ecs_task_definition.spacedRepetitionTaskDefinition.arn}"
  desired_count = 1
  cluster = "${aws_ecs_cluster.spacedRepetitionECSCluster.arn}"
  load_balancer = []
  network_configuration = [
    {
      subnets = [
        "${aws_subnet.spacedRepetitionSubnet.id}",
        "${aws_subnet.spacedRepetitionSubnet2.id}"
      ]
    }
	]
}

resource "aws_ecr_repository" "spacedRepetitionECR" {
  name = "spaced-repetition-spring-boot"
}

resource "aws_ecr_repository" "spacedRepetitionMysqlECR" {
  name = "spaced-repetition-mysql"
}

resource "aws_ecs_task_definition" "spacedRepetitionTaskDefinition" {
  family = "SpacedRepetition"
  container_definitions = "${data.template_file.containers.rendered}"
  execution_role_arn = "${aws_iam_role.executionRole.arn}"
  network_mode = "awsvpc"
  cpu = 1024
  memory = 2048
  requires_compatibilities = ["FARGATE"]
}

output "ecr-spring-boot" {
  value = "${aws_ecr_repository.spacedRepetitionECR.repository_url}"
}

output "ecr-mysql" {
  value = "${aws_ecr_repository.spacedRepetitionMysqlECR.repository_url}"
}

