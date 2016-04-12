# grafana_mongodb_dashboards

Grafana dashboard templates for use with the [prometheus_mongodb_exporter](https://github.com/Percona-Lab/prometheus_mongodb_exporter) for MongoDB w/Prometheus

### Features
  - Cluster Summary, Sharding, Replica Set and single-instance dashboards for Percona Server MongoDB / MongoDB
  - Grouping of OS metrics with MongoDB instances
  - Cluster, replica set and node member discovery via Prometheus data
  - WiredTiger storage engine metrics (*beta/experimental*)

### Required

1. A Prometheus server (*https://prometheus.io/*)
1. A Grafana 2.0+ server (*http://grafana.org/*)
1. The [prometheus_mongodb_exporter](https://github.com/Percona-Lab/prometheus_mongodb_exporter) for Prometheus on at least one Percona Server MongoDB or MongoDB instance
1. The [node_exporter](https://github.com/prometheus/node_exporter) for Prometheus on each node running the [prometheus_mongodb_exporter](https://github.com/Percona-Lab/prometheus_mongodb_exporter)
1. "Target Group" labels in Prometheus server configuration file (*explained later*)

### Prometheus Configuration

The grouping of metrics between the OS (*node_exporter*) and MongoDB (*prometheus_mongodb_metrics*) is achieved by using labels applied to [Prometheus Target Groups](https://prometheus.io/docs/operating/configuration/#<target_group>) in the Prometheus server config file (prometheus.yml).

Each MongoDB instance to be monitored must be added as a 'target' in the prometheus.yml file with the following required labels:
1. 'cluster' - A human-defined name for the cluster the node is part of
1. 'alias' - A field containing the MongoDB hostname/port combination for the instance
1. 'group' - A field for grouping node types: 'mongod' 
1. 'replset' - An optional field for instances that are members of a MongoDB Replication Set. This must match the replset name seen in the MongoDB command '*rs.status()*'.

### Installation

 TBD

### Todos
 - Write Tests
 - Get WiredTiger storage engine metrics to stable state (*beta/experimental now*) 
 - Add storage engine metrics for PerconaFT and RocksDB
 - Automate/rethink target 'labels' in prometheus.yml (*used for grouping metrics in graphs*)
