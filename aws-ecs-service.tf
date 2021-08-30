resource "aws_ecs_service" "general" {
  name = var.name
  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_strategy == null ? [] : [var.capacity_provider_strategy]
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight = capacity_provider_strategy.value.weight
      base = capacity_provider_strategy.value.base
    }
  }
  cluster = var.cluster
  deployment_maximum_percent = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  dynamic "deployment_controller" {
    for_each = var.deployment_controller == null ? [] : [var.deployment_controller]
    content {
      type = deployment_controller.value.type
    }
  }

  desired_count = var.desired_count
  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  enable_execute_command = var.enable_execute_command
  force_new_deployment = var.force_new_deployment
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  iam_role = var.iam_role
  launch_type = var.launch_type

  dynamic "load_balancer" {
    for_each = var.load_balancer == null ? [] : [var.load_balancer]
    content {
      elb_name = load_balancer.value.elb_name
      target_group_arn = load_balancer.value.target_group_arn
      container_name = load_balancer.value.container_name
      container_port = load_balancer.value.container_port
    }
  }

  dynamic "network_configuration" {
    for_each = var.network_configuration == null ? [] : [var.network_configuration]
    content {
      subnets = network_configuration.value.subnets
      security_groups = network_configuration.value.security_groups
      assign_public_ip = network_configuration.value.assign_public_ip
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy == null ? [] : [var.ordered_placement_strategy]
    content {
      type = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  dynamic "placement_constraints" {
    for_each = var.placement_constraints == null ? [] : [var.placement_constraints]
    content {
      type = placement_constraints.value.type
      expression = placement_constraints.value.expression
      # expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
    }
  }

  platform_version = var.platform_version
  propagate_tags = var.propagate_tags
  scheduling_strategy = var.scheduling_strategy

  dynamic "service_registries" {
    for_each = var.service_registries == null ? [] : [var.service_registries]
    content {
      registry_arn = var.registry_arn
      port = var.port
      container_port = var.container_port
      container_name = var.container_name
    }
  }

  task_definition = var.task_definition
  wait_for_steady_state = var.wait_for_steady_state
  tags = var.tags
}