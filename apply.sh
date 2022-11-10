#!/bin/sh

terraform apply -var="confluent_cloud_api_key=PUT_YOUR_CLOUD_API_KEY_HERE" -var="confluent_cloud_api_secret=PUT_YOUR_CLOUD_API_SECRET"
