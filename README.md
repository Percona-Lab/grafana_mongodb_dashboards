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

The grouping of metrics of the OS (*node_exporter*) and MongoDB (*prometheus_mongodb_metrics*) is achieved by using labels applied to [Prometheus Target Groups](https://prometheus.io/docs/operating/configuration/#<target_group>) in the Prometheus server config file (prometheus.yml).

Each MongoDB instance to be monitored must be added as a new group in the prometheus.yml file with both the 'node' and 'mongodb' exporter as 'targets'.

Each MongoDB instance added must also have the following labels added to it's target group:

1. '**cluster**' - A human-defined name for the cluster the node is part of.  **_required_**
1. '**alias**' - A field containing the MongoDB hostname/port combination for the instance.  **_required_**
1. '**nodetype**' - A field for grouping node types: 'mongod' for standalone/replset instances, 'config' for shard config servers and 'mongos' for shard mongos instances.  **_required_**
1. '**replset**' - An field for instances that are members of a MongoDB Replication Set. This must match the replset name seen in the MongoDB command '*rs.status()*'. **_optional_**

Example of config for a replset member:

```
      - targets: ['tyrion.westeros.com:9140','tyrion.westeros.com:9100']
        labels:
          alias: 'tyrion.westeros.com:27017'
          nodetype: 'mongod'
          replset: 'shard12'
          cluster: 'prodWebsite'
```

Example of config for a mongos member (notice no 'replset' label):

```
      - targets: ['arya.westeros.com:9140','arya.westeros.com:9100']
        labels:
          alias: 'arya.westeros.com:27018'
          nodetype: 'mongos'
          cluster: 'prodWebsite'
```

### Installation

1. Install and start Prometheus and Grafana 2.0+ servers with default configuration (not explained here)
2. Configure Grafana to use Prometheus as a Data Source (not expained here)
3. Install [prometheus_mongodb_exporter](https://github.com/Percona-Lab/prometheus_mongodb_exporter) on all nodes that run MongoDB. **Link TBD**
4. Install [node_exporter](https://github.com/prometheus/node_exporter) on all nodes that run the prometheus_mongodb_exporter
5. For each instance to monitor, add 'targets' and 'labels' to the prometheus.yml file as described in '*Prometheus Configuration*' section above.
6. Reload Prometheus configuration file (or restart Prometheus). **Link TBD**
7. Import the Grafana template .json files from this project into Grafana's UI. **Steps TBD**

### Todos
 - Write Tests
 - Get WiredTiger storage engine metrics to stable state (*beta/experimental now*) 
 - Add storage engine metrics for PerconaFT and RocksDB
 - Automate/rethink target 'labels' in prometheus.yml (*used for grouping metrics in graphs*)

