# grafana_mongodb_dashboards

Grafana dashboard templates for use with the [prometheus_mongodb_exporter](https://github.com/Percona-Lab/prometheus_mongodb_exporter) for MongoDB w/Prometheus

### Features
  - Cluster Summary, Sharding, Replica Set and single-instance dashboards for Percona Server MongoDB / MongoDB
  - Grouping of OS metrics with MongoDB instances
  - Cluster, replica set and node member discovery via Prometheus data
  - WiredTiger storage engine metrics (currently in beta/experimental)

### Requires

1. A Prometheus server (https://prometheus.io/)
1. A Grafana 2.0+ server (http://grafana.org/)
1. The [prometheus_mongodb_exporter](https://github.com/Percona-Lab/prometheus_mongodb_exporter) for Prometheus on at least one Percona Server MongoDB or MongoDB instance
1. The [node_exporter](https://github.com/prometheus/node_exporter) for Prometheus on each node running the [prometheus_mongodb_exporter](https://github.com/Percona-Lab/prometheus_mongodb_exporter)

### Configuration

TBD

### Installation

 TBD

### Todos

 - Write Tests
 - Get WiredTiger storage engine metrics to stable (experimental now) 
 - Add storage engine metrics for PerconaFT and RocksDB
 - Automate/rethink target 'labels' in prometheus.yml (used for grouping in graphs)
