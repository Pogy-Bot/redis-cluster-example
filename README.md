# Redis Cluster with RedisJSON + RedisSearch but for development

This is meant if you wanna do redis clustering locally, since it will open up redis on CMD, which is not good for production use.

Make sure to have Rust on your machine installed to compile the plugins.

## Summary of Steps

*Step 1 and 2 are incase plugins cannot somehow work in the plugins folder in this repo.*
1- Download RedisJSON plugin - optional
2- Download Redis Search plugin - optional
3- Edit your cluster.sh to fit your needs, how many nodes, the file path, etc.
4- Give permissions to the cluster.sh file
5- Run the cluster.sh file
6- Run the redis command to link the clusters

### 1- Download RedisJSON plugin
If you decided to build it from source, here are the commands to do so:
```bash
git clone https://github.com/RedisJSON/RedisJSON
cd RedisJSON
cargo build --release
cd .. # go back to where you started
```

then go to each redis.conf and change the path to 
```bash
loadmodule /path/to/RedisJSON/target/release/librejson.so
```

### 2- Download Redis Search plugin
If you decided to build it from source, here are the commands to do so:
```bash
git clone --recursive https://github.com/RediSearch/RediSearch.git
cd RediSearch
make setup
make build
cd .. # go back to where you started
```

then go to each redis.conf and change the path. To find the path run:
```bash
find . -name "redisearch.so"
```

and use the path that is returned.

### 3- Edit your cluster.sh to fit your needs

The cluster.sh file takes default root level paths, but you might wanna recheck how many nodes you want to uncomment and the file paths. And you can go to each Port and edit its redis.conf file to fit your needs.

### 4- Give permissions to the cluster.sh file

You will need to give permissions to the cluster.sh file for it to open up the redis servers.

```bash
chmod +x cluster.sh
```

Also give permissions to the plugins folder if you want to use them.
```bash
chmod +x plugins/librejson.so
chmod +x plugins/redisearch.so
```
### 5- Run the cluster.sh file

```bash
sh ./cluster.sh
```

or just use `sudo sh ./cluster.sh` if you get permission errors.

### 6- Run the redis command to link the clusters

_note: if you want up to 12 nodes go to cluster.sh and uncoment the nodes you want and add them in the above command_

ex. Running 6 (default)

```console
redis-cli --cluster create \
  127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 \
  127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006 \
  --cluster-replicas 1
```

### Extra

you can use the `redis-cli` to connect to the cluster and run commands

ex, checking your clusters:

```console
redis-cli -c -p 7001
```
then
```
CLUSTER NODES
```

### Errors

- If you encounter setup errors just stop the session with

```
tmux kill-session -t redis-cluster
```

and then run `./cluster.sh` again.

- If you get cluster formatting errors use
```bash
tr -d '\r' < cluster.sh > cluster_fixed.sh
```

and then run `./cluster_fixed.sh` instead.