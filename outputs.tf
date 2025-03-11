output "alb_hostname" {
  value = "${aws_alb.app-alb.dns_name}"
}
output "ecs_cluster" {
  value = "${aws_ecs_cluster.app-cluster.name}"
}
output "ecs_service" {
  value = "${aws_ecs_service.app-srv.name}"
}
output "task_def_arn" {
  value = "${aws_ecs_task_definition.app-td.arn}"
}
output "app_container_name" {
  value = jsondecode(aws_ecs_task_definition.app-td.container_definitions)[0].name
}

