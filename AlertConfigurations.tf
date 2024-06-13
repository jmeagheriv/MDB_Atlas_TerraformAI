
resource "mongodbatlas_third_party_integration" "test" {
  project_id = var.project_id
  type       = "DATADOG"
  api_key    = var.datadog_api_key
  region     = var.datadog_region
}



resource "mongodbatlas_alert_configuration" "alert_auth" {  
   
  event_type = "OUTSIDE_METRIC_THRESHOLD"
    enabled    = true
    project_id = var.project_id
    
   
  notification {     
    interval_min  = 60
    delay_min     = 0     
    datadog_region = "US"
    type_name = "DATADOG" 
     
    integration_id = mongodbatlas_third_party_integration.test.id
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
