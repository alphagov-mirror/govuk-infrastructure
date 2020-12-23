resource "aws_service_discovery_service" "service" {
  count = var.service_discovery_namespace_id == null ? 0 : length(local.container_services)

  name = local.container_services[count.index].container_service

  dns_config {
    namespace_id = var.service_discovery_namespace_id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "WEIGHTED"
  }
}
