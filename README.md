# Redis Cluster with RedisJSON + RedisSearch but for production

This is meant if you wanna do redis clustering on production, it will open up redis on different services.

If you want to do it locally on development, here is the branch for it [https://github.com/Pogy-Bot/redis-cluster-example/tree/clustering-development](https://github.com/Pogy-Bot/redis-cluster-example/tree/clustering-development)


## Notes
- If you wanna build the plugins, make sure you have the language rust installed
- You should be using systemd to manage your services or it will not work

## Summary of Steps

_Step 1 and 2 are incase plugins cannot somehow work in the plugins folder in this repo._
1- Download RedisJSON plugin - optional
2- Download Redis Search plugin - optional
3- Initializing
4- Start services
5- Run the redis command to link the clusters

### 1- Download RedisJSON plugin - optional

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

### 2- Download Redis Search plugin - optional

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

### 3- Initializing
Install `redis-server` and disable the service

```bash
sudo apt-get update # update the package list
sudo apt-get install redis-server # install redis
sudo systemctl disable redis-server.service # disable the service
```

Create a redis user and a redis group for the Redis Server services and give them the correct permissions by running the following commands:

```bash
sudo chown redis:redis -R /etc/redis
```

Go through each folder, and customize the `redis.conf` and service file to your needs.

After you're done copy all the files to `/etc/redis/`
```bash
# if you're in the root of the repo
sudo cp -r * /etc/redis/

# if you're in another folder
sudo cp -r /path/to/redis-cluster-example/* /etc/redis/
```

and give execution permissions

```bash
chmod +x create.sh
chmod +x start.sh
chmod +x status.sh
chmod +x stop.sh
chmod +x /etc/redis
```


### 4- Do the magic

To Create the services

```bash
sh ./create.sh
```

To start the services (on boot too)

```bash
sh ./start.sh
```

To check the status of the services

```bash
sh ./status.sh
```

To stop the services (stops, and disables on boot)

```bash
sh ./stop.sh
```

### 5- Run the redis command to link the clusters

The command is used to create a Redis cluster.

`redis-cli` is the Redis command line interface.

The `--cluster create` option is used to create a new Redis cluster.

The IP addresses and port numbers provided in the command 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006 etc specify the nodes that will be part of the cluster. The IP address 127.0.0.1 is the localhost address, which means the nodes are running on the same machine as the Redis client. The port numbers specify the individual nodes of the cluster.

The `--cluster-replicas 1` option sets the number of replicas for each key in the cluster to 1. This means that for each key, there will be one additional copy stored in another node in the cluster to provide redundancy in case of a node failure.

In conclusion, this command creates a Redis cluster with the specified nodes, with each key having one replica stored in another node.

```console
redis-cli --cluster create \
  127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 \
  127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006 \
  127.0.0.1:7007 127.0.0.1:7008 127.0.0.1:7009 \
  127.0.0.1:7010 127.0.0.1:7011 127.0.0.1:7012 \
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

- If you get cluster formatting errors use

```bash
tr -d '\r' < filename.sh > filename_fixed.sh
```

and then run `./filename_fixed.sh` instead.
