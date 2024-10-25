resource "mongodbatlas_advanced_cluster" "my_cluster0" {
  project_id   = var.project_id
  name         = "TF-CopilotM10"
  cluster_type = "REPLICASET"
  mongo_db_major_version = 6.0
  replication_specs {
    num_shards = 1    
    region_configs {
      electable_specs {
        instance_size = "M10"
        node_count    = 3
      }      
      provider_name = var.cloud_provider
      region_name   = var.region_name
      priority      = 7
    }
  }  
  backup_enabled = true # enable cloud backup snapshots
}

resource "mongodbatlas_advanced_cluster" "my_cluster1" {
  project_id   = var.project_id
  name         = "TF-CopilotM40"
  cluster_type = "REPLICASET"
  mongo_db_major_version = 6.0
  replication_specs {
    num_shards = 1    
    region_configs {
      electable_specs {
        instance_size = "M40_NVME"
        node_count    = 3
      }      
      provider_name = var.cloud_provider
      region_name   = var.region_name
      priority      = 7
    }
  }  
  backup_enabled = true # enable cloud backup snapshots
}
resource "mongodbatlas_alert_configuration" "test" {
  project_id = var.project_id
  event_type = "OUTSIDE_METRIC_THRESHOLD"
  enabled    = true

  notification {
    type_name     = "GROUP"
    interval_min  = 5
    delay_min     = 0
    sms_enabled   = false
    email_enabled = true
    roles         = ["GROUP_CLUSTER_MANAGER"]
  }

  matcher {
    field_name = "HOSTNAME_AND_PORT"
    operator   = "EQUALS"
    value      = "SECONDARY"
  }

  metric_threshold_config {
    metric_name = "ASSERT_REGULAR"
    operator    = "LESS_THAN"
    threshold   = 99.0
    units       = "RAW"
    mode        = "AVERAGE"
  }
}
