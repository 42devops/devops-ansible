#!/bin/bash
set -e

function cleanup {
  # cleanup work
  rm -rf binaries
}
trap cleanup SIGHUP SIGINT SIGTERM

pushd $(dirname $0)
mkdir -p binaries

# prometheus
PROMETHEUS_VERSION=${PROMETHEUS_VERSION:-"2.7.1"}
echo "Prepare PROMETHEUS ${PROMETHEUS_VERSION} release ..."
grep -q "^${PROMETHEUS_VERSION}\$" binaries/.PROMETHEUS 2>/dev/null || {
  curl -L  https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz -o binaries/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
  echo ${PROMETHEUS_VERSION} > binaries/.PROMETHEUS
}

# alertmanager
ALERTAMANAGER_VERSION=${ALERTAMANAGER_VERSION:-"0.16.1"}
echo "Prepare ALERTAMANAGER ${ALERTAMANAGER_VERSION} release ..."
grep -q "^${ALERTAMANAGER_VERSION}\$" binaries/.ALERTAMANAGER 2>/dev/null || {
  curl -L  https://github.com/prometheus/alertmanager/releases/download/v${ALERTAMANAGER_VERSION}/alertmanager-${ALERTAMANAGER_VERSION}.linux-amd64.tar.gz -o binaries/alertmanager-${ALERTAMANAGER_VERSION}.linux-amd64.tar.gz
  echo ${ALERTAMANAGER_VERSION} > binaries/.ALERTAMANAGER
}

# NODE_EXPORTER
NODE_EXPORTER_VERSION=${NODE_EXPORTER_VERSION:-"0.17.0"}
echo "Prepare NODE_EXPORTER ${NODE_EXPORTER_VERSION} release ..."
grep -q "^${NODE_EXPORTER_VERSION}\$" binaries/.NODE_EXPORTER 2>/dev/null || {
  curl -L  https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -o binaries/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
  echo ${NODE_EXPORTER_VERSION} > binaries/.NODE_EXPORTER
}

# BLACKBOX_EXPORTER
BLACKBOX_EXPORTER_VERSION=${BLACKBOX_EXPORTER_VERSION:-"0.13.0"}
echo "Prepare BLACKBOX_EXPORTER ${BLACKBOX_EXPORTER_VERSION} release ..."
grep -q "^${BLACKBOX_EXPORTER_VERSION}\$" binaries/.BLACKBOX_EXPORTER 2>/dev/null || {
  curl -L  https://github.com/prometheus/blackbox_exporter/releases/download/v${BLACKBOX_EXPORTER_VERSION}/blackbox_exporter-${BLACKBOX_EXPORTER_VERSION}.linux-amd64.tar.gz -o binaries/blackbox_exporter-${BLACKBOX_EXPORTER_VERSION}.linux-amd64.tar.gz
  echo ${BLACKBOX_EXPORTER_VERSION} > binaries/.BLACKBOX_EXPORTER
}



echo "Done! All your binaries locate in script/binaries directory"
popd
