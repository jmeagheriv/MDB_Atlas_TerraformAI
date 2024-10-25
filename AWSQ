
resource "mongodbatlas_alert_configuration" "cloud_backup_alert" {
  project_id = var.atlas_project_id
  event_type = "BACKUP"
  enabled    = true

  matcher {
    field_name = "CLUSTER_NAME"
    operator   = "EQUALS"
    value      = "YOUR_CLUSTER_NAME"
  }

  matcher {
    field_name = "TYPE_NAME"
    operator   = "EQUALS"
    value      = "CLUSTER"
  }

  notification {
    type_name     = "GROUP"
    interval_min  = 5
    delay_min     = 0
    sms_enabled   = false
    email_enabled = true
  }

  notification {
    type_name    = "EMAIL"
    interval_min = 5
    delay_min    = 0
    email_address = "your-email@example.com"
  }

  threshold_config {
    operator    = "LESS_THAN"
    threshold   = 1
    units       = "RAW"
    metric_name = "BACKUP_HEALTHY"
  }
}

resource "mongodbatlas_cluster" "m40_nvme_cluster" {
  project_id             = var.atlas_project_id
  name                   = "m40-nvme-cluster"
  cluster_type           = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "5.0"

  # M40 cluster tier with NVMe storage
  provider_name               = "AWS"
  provider_instance_size_name = "M40_NVME"
  
  # NVMe storage requires a minimum disk size
  provider_volume_type        = "PROVISIONED"
  disk_size_gb                = 100

  # Advanced configuration options
  advanced_configuration {
    javascript_enabled                   = true
    minimum_enabled_tls_protocol         = "TLS1_2"
    no_table_scan                        = false
    oplog_size_mb                        = 2048
    sample_size_bi_connector             = 1000
    sample_refresh_interval_bi_connector = 300
  }

  # Enabling additional features
  bi_connector {
    enabled         = true
    read_preference = "SECONDARY"
  }

  # Performance advisor settings
  performance_advisor {
    enabled = true
    enable_managed_namespaces = true
  }

  # Enabling database auditing
  auditing {
    enabled = true
  }

  # Encryption at rest using AWS KMS
  encryption_at_rest_provider = "AWS"
}


resource "mongodbatlas_cluster" "my_cluster" {
  project_id             = var.atlas_project_id
  name                   = "my-m10-cluster"
  cluster_type           = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "5.0"

  # M10 cluster tier
  provider_name               = "AWS"
  provider_instance_size_name = "M10"
  
  # Advanced configuration options
  advanced_configuration {
    javascript_enabled                   = true
    minimum_enabled_tls_protocol         = "TLS1_2"
    no_table_scan                        = false
    oplog_size_mb                        = 1024
    sample_size_bi_connector             = 100
    sample_refresh_interval_bi_connector = 300
  }
}
