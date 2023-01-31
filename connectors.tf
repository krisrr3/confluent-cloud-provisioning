resource "confluent_kafka_acl" "payments_events_s3sink_connector_describe_on_cluster" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "CLUSTER"
  resource_name = "kafka-cluster"
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "DESCRIBE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_read_on_target_topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "TOPIC"
  resource_name = "payments_json_events"
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "READ"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_create_on_dlq_lcc_topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "TOPIC"
  resource_name = "dlq-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_write_on_dlq_lcc_topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "TOPIC"
  resource_name = "dlq-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_create_on_success_lcc_topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "TOPIC"
  resource_name = "success-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_write_on_success_lcc_topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "TOPIC"
  resource_name = "success-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_create_on_error_lcc_topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "TOPIC"
  resource_name = "error-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "CREATE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_write_on_error_lcc_topics" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "TOPIC"
  resource_name = "error-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}

resource "confluent_kafka_acl" "payments_events_s3sink_connector_read_on_connect_lcc_group" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  resource_type = "GROUP"
  resource_name = "connect-lcc"
  pattern_type  = "PREFIXED"
  principal     = "User:${confluent_service_account.app_manager_dev.id}"
  host          = "*"
  operation     = "READ"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
  depends_on = [
    confluent_kafka_cluster.cluster_dev
  ]
}


resource "confluent_connector" "payments_events_s3sink_connector" {
  environment {
    id = confluent_environment.payhive_development.id
  }
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }

  config_sensitive = {
    "kafka.api.key" =confluent_api_key.app_manager_dev_api_key.id
    "kafka.api.secret"=confluent_api_key.app_manager_dev_api_key.secret
    "aws.access.key.id" = var.aws_access_key_id
    "aws.secret.access.key" = var.aws_access_key_secret
  }

  config_nonsensitive = {
    "connector.class"          = "S3_SINK"
    "name"                     = "payments_events_s3sink_connector"
    "kafka.auth.mode"          = "KAFKA_API_KEY"
    # "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    # "kafka.service.account.id" = confluent_service_account.app_manager_dev.id
    "topics" = "payments_json_events"
    "input.data.format" = "JSON"
    "s3.bucket.name" = "payhive.lifecycle.records"
    "s3.part.size" = "5242880"
    "s3.wan.mode" = "false"
    "output.data.format" = "JSON"
    "output.keys.format" = "JSON"
    "output.headers.format" = "JSON"
    "topics.dir" = "topics"
    "path.format" = "'year'=YYYY/'month'=MM/'day'=dd/'hour'=HH"
    "time.interval" = "HOURLY"
    "rotate.schedule.interval.ms" = "-1"
    "rotate.interval.ms" = "3600000"
    "flush.size" = "1000"
    "behavior.on.null.values" = "ignore"
    "timezone" = "UTC"
    "subject.name.strategy" = "TopicNameStrategy"
    "tombstone.encoded.partition" = "tombstone"
    "enhanced.avro.schema.support" = "true"
    "locale" = "en"
    "s3.schema.partition.affix.type" = "NONE"
    "schema.compatibility" = "NONE"
    "store.kafka.keys" = "false"
    "value.converter.connect.meta.data" = "true"
    "store.kafka.headers" = "false"
    "s3.object.tagging" = "false"
    "tasks.max" = "1"
  }

  lifecycle {
    prevent_destroy = false
  }
  
  depends_on = [
    confluent_kafka_acl.payments_events_s3sink_connector_describe_on_cluster,
    confluent_kafka_acl.payments_events_s3sink_connector_read_on_target_topic,
    confluent_kafka_acl.payments_events_s3sink_connector_create_on_dlq_lcc_topics,
    confluent_kafka_acl.payments_events_s3sink_connector_write_on_dlq_lcc_topics,
    confluent_kafka_acl.payments_events_s3sink_connector_create_on_success_lcc_topics,
    confluent_kafka_acl.payments_events_s3sink_connector_write_on_success_lcc_topics,
    confluent_kafka_acl.payments_events_s3sink_connector_create_on_error_lcc_topics,
    confluent_kafka_acl.payments_events_s3sink_connector_write_on_error_lcc_topics,
    confluent_kafka_acl.payments_events_s3sink_connector_read_on_connect_lcc_group,
    confluent_kafka_cluster.cluster_dev
  ]

}
