#!/bin/bash
source ./secure-docker-image/.env

chmod +x .git/hooks/pre-commit
export PATH="$PATH:/usr/bin/sonar-scanner"
sonar-scanner \
  -Dsonar.projectKey=secure-docker-image \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=$SONAR_LOGIN \
  -Dsonar.password=$SONAR_PASSWORD \
  -Dsonar.qualitygate.wait=true