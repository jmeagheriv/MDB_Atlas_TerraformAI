resource "mongodbatlas_cluster" "m10_cluster" {
  project_id   = mongodbatlas_project.atlas-project.id
  name         = "${var.atlas_project_name}-${var.environment}-m10-cluster"
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.atlas_region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup     = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "7.0"
  # Provider Settings "block"
  provider_name               = var.cloud_provider
  provider_disk_type_name     = "P6"
  provider_instance_size_name = "M10"
}

resource "mongodbatlas_cluster" "m40_nvme_cluster" {
  project_id   = mongodbatlas_project.atlas-project.id
  name         = "${var.atlas_project_name}-${var.environment}-m40-nvme-cluster"
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.atlas_region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup     = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "7.0"
  # Provider Settings "block"
  provider_name               = var.cloud_provider
  provider_disk_type_name     = "NVME"
  provider_instance_size_name = "M40"
}

resource "mongodbatlas_alert_configuration" "example_alert" {
  project_id = mongodbatlas_project.atlas-project.id
  event_type_name = "OUTSIDE_METRIC_THRESHOLD"
  enabled = true
  matcher {
    field_name = "HOSTNAME"
    operator   = "EQUALS"
    value      = "example.mongodb.net"
  }
  metric_threshold {
    metric_name = "DISK_PARTITION_SPACE_USED"
    operator    = "GREATER_THAN"
    threshold   = 80
    units       = "PERCENT"
    mode        = "AVERAGE"
  }
  notification {
    type_name = "EMAIL"
    interval_min = 5
    delay_min = 0
    email_address = "example@example.com"
  }
}

