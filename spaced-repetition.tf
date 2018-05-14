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
}

output "ecr-spring-boot" {
  value = "${aws_ecr_repository.spacedRepetitionECR.repository_url}"
}

output "ecr-mysql" {
  value = "${aws_ecr_repository.spacedRepetitionMysqlECR.repository_url}"
}
