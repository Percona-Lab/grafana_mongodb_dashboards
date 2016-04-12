#!/bin/bash

set -e

[ -d example ] && rm -rf example
mkdir -p example/data example/log example/tmp
piddir=$(readlink -f example/tmp)
logdir=$(readlink -f example/log)
datadir=$(readlink -f example/data)

echo -e "\n### Starting 2 x nodes for 'shard1' replica set\n"
mkdir $datadir/37017 $datadir/37027 $logdir/37017 $logdir/37027
mongod --port 37017 --dbpath $datadir/37017 --logpath $logdir/37017/mongod.log --pidfilepath $piddir/mongod.37017.pid --smallfiles --oplogSize 50 --replSet shard1 --fork
mongod --port 37027 --dbpath $datadir/37027 --logpath $logdir/37027/mongod.log --pidfilepath $piddir/mongod.37027.pid --smallfiles --oplogSize 50 --replSet shard1 --fork

echo -e "\n### Starting cluster config node\n"
mkdir $datadir/37019 $logdir/37019
mongod --port 37019 --dbpath $datadir/37019 --logpath $logdir/37019/mongod.log --pidfilepath $piddir/mongod.37019.pid --smallfiles --oplogSize 50 --configsvr --fork

echo -e "\n### Waiting 15 seconds...\n"
sleep 15

echo -e "\n### Starting cluster sharding node (mongos)\n"
mkdir $logdir/37018
mongos --port 37018 --logpath $logdir/37018/mongos.log --pidfilepath $piddir/mongos.37018.pid --configdb localhost:37019 --fork

echo -e "\n### Initiating shard1 replset\n"
echo 'rs.initiate({ "_id" : "shard1", "members" : [
	{ "_id" : 0, "host" : "localhost:37017" },
	{ "_id" : 1, "host" : "localhost:37027" } ]
})' | mongo --port 37017 | tail -n+3 | grep -v ^bye$
sleep 5

echo -e "\n### Initiating a 1-shard cluster\n"
echo 'sh.addShard("shard1/localhost:37017")' | mongo --port 37018 | tail -n+3 | grep -v ^bye$
echo 'sh.enableSharding("testSharding")' | mongo --port 37018 | tail -n+3 | grep -v ^bye$
echo 'sh.shardCollection("testSharding.test", { _id : 1 })' | mongo --port 37018 | tail -n+3 | grep -v ^bye$

echo -e "\n### Done!"
