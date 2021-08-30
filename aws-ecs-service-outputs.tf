output "name" {
  value = aws_ecs_service.general.name
}

output "id" {
  value = aws_ecs_service.general.id
}

output "cluster" {
  value = aws_ecs_service.general.cluster
}

output "iam_role" {
  value = aws_ecs_service.general.iam_role
}

output "desired_count" {
  value = aws_ecs_service.general.desired_count
}
