# Configure the Confluent Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.13.0"
    }
  }
}

variable "confluent_cloud_api_key" {
  type     = string
  nullable = false
}

variable "confluent_cloud_api_secret" {
  type     = string
  nullable = false
}

variable "region" {
  type     = string
  nullable = false
}

variable "aws_access_key_id" {
  type     = string
  nullable = false
}

variable "aws_access_key_secret" {
  type     = string
  nullable = false
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key    # optionally use CONFLUENT_CLOUD_API_KEY env var
  cloud_api_secret = var.confluent_cloud_api_secret # optionally use CONFLUENT_CLOUD_API_SECRET env var
}

resource "confluent_environment" "payhive_development" {
  display_name = "Development"

  lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_kafka_cluster" "cluster_dev" {
  display_name = "cluster_dev"
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = var.region
  standard {}

  environment {
    id = confluent_environment.payhive_development.id
  }

  lifecycle {
    prevent_destroy = false
  }
}


resource "confluent_service_account" "app_manager_dev" {
  display_name = "app_manager_dev"
  description  = "Service account to manage Kafka cluster"
}

resource "confluent_service_account" "test_harness_sa" {
  display_name = "test-harness-sa"
  description  = "Service account that can write messages to the events topic"
}

resource "confluent_role_binding" "app_manager_dev" {
  principal   = "User:${confluent_service_account.app_manager_dev.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.cluster_dev.rbac_crn
}

resource "confluent_role_binding" "test_harness_sa_write_to_topic" {
  principal   = "User:${confluent_service_account.test_harness_sa.id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${confluent_kafka_cluster.cluster_dev.rbac_crn}/kafka=${confluent_kafka_cluster.cluster_dev.id}/topic=${confluent_kafka_topic.payments_json_events.topic_name}"
}

resource "confluent_api_key" "test_harness_api_key" {
  display_name = "test_harness_api_key"
  description  = "Kafka API Key owned by the 'test_harness_sa' service account"
  owner {
    id          = confluent_service_account.test_harness_sa.id
    api_version = confluent_service_account.test_harness_sa.api_version
    kind        = confluent_service_account.test_harness_sa.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.cluster_dev.id
    api_version = confluent_kafka_cluster.cluster_dev.api_version
    kind        = confluent_kafka_cluster.cluster_dev.kind

    environment {
      id = confluent_environment.payhive_development.id
    }
  }
}

resource "confluent_api_key" "app_manager_dev_api_key" {
  display_name = "app_manager_dev_api_key"
  description  = "Kafka API Key owned by the 'app_manager_dev' service account"
  owner {
    id          = confluent_service_account.app_manager_dev.id
    api_version = confluent_service_account.app_manager_dev.api_version
    kind        = confluent_service_account.app_manager_dev.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.cluster_dev.id
    api_version = confluent_kafka_cluster.cluster_dev.api_version
    kind        = confluent_kafka_cluster.cluster_dev.kind

    environment {
      id = confluent_environment.payhive_development.id
    }
  }
  
  # Wait until the necessary role has been bound to the service account,
  # to avoid race condition with topic creation
  depends_on = [
    confluent_role_binding.app_manager_dev
    #confluent_kafka_acl.app_manager_dev
  ]
}


resource "confluent_kafka_topic" "payments_json_events" {
  kafka_cluster {
    id = confluent_kafka_cluster.cluster_dev.id
  }
  topic_name       = "payments_json_events"
  rest_endpoint    = confluent_kafka_cluster.cluster_dev.rest_endpoint
  credentials {
    key    = confluent_api_key.app_manager_dev_api_key.id
    secret = confluent_api_key.app_manager_dev_api_key.secret
  }
}
