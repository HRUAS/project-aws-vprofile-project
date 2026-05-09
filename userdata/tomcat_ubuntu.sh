#!/bin/bash
set -e

sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y openjdk-21-jdk tomcat10 tomcat10-admin tomcat10-docs tomcat10-common git

JAVA_HOME_PATH="/usr/lib/jvm/java-21-openjdk-amd64"
if [ ! -d "$JAVA_HOME_PATH" ]; then
  JAVA_HOME_PATH="$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")"
fi

sudo sed -i '/^JAVA_HOME=/d' /etc/default/tomcat10
echo "JAVA_HOME=$JAVA_HOME_PATH" | sudo tee -a /etc/default/tomcat10

sudo systemctl daemon-reload
sudo systemctl enable tomcat10
sudo systemctl restart tomcat10
