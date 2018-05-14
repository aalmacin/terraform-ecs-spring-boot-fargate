
resource "aws_ecs_cluster" "spacedRepetitionECSCluster" {
  name = "SpacedRepetition"
}

resource "aws_ecr_repository" "spacedRepetitionECR" {
  name = "spaced-repetition-spring-boot"
}

resource "aws_ecs_task_definition" "spacedRepetitionTaskDefinition" {
  family = "Spaced Repetition"
  container_definitions = "${file("spacedRepetitionContainerDefinitions.json")}"
}
