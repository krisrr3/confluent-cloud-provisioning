#!/bin/sh

terraform destroy -var="confluent_cloud_api_key=CLOUD_API_KEY" -var="confluent_cloud_api_secret=CLOUD_API_SECRET"
