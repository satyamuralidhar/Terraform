#!/bin/bash
# sleep 30
# terraform output -json |\
# jq -r '.instance_ip_addr.value' |\
# xargs -I {} curl -v http://{}:80 -m 10