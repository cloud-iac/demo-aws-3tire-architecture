#!/bin/bash
yum update -y
yum install -y docker docker-registry
systemctl start docker.service
systemctl enable docker.service