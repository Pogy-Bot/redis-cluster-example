# Redis Node (Normal)

This example is to simply run redis with redisearch and redisnode with PERSISTANT storage.

## Notes

- If you wanna build the plugins, make sure you have the language rust installed
- You should be using systemd to manage your services or it will not work

## Summary of Steps

_Step 1 and 2 are incase plugins cannot somehow work in the plugins folder in this repo._

- Download RedisJSON plugin - optional
- Download Redis Search plugin - optional
- Initializing
- Run the redis command to link the clusters

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

Create and edit the /etc/rc.local file by running the following command:

```
sudo nano /etc/rc.local
```

and add to its content, press CTRL + X then Y to save and exit

```
 #!/bin/sh -e
 #
 # rc.local
 #
 # This script is executed at the end of each multiuser runlevel.
 # Make sure that the script will "exit 0" on success or any other
 # value on error.
 #
 # In order to enable or disable this script just change the execution
 # bits.
 #
 # By default this script does nothing.
 echo never > /sys/kernel/mm/transparent_hugepage/enabled
 sysctl -w net.core.somaxconn=65535

 exit 0
```

Give executable permissions to the `/etc/rc.local` file by running the following command:

```bash
sudo chmod +x /etc/rc.local
```

Edit the `/etc/sysctl.conf` by running the following command:

```bash
sudo nano /etc/sysctl.conf
```

Add the following line at the end of the file:

```bash
vm.overcommit_memory=1
```

clone the current repo and CD to it

```bash
# clone branch redis-no-cluster
git clone https://github.com/Pogy-Bot/redis-cluster-example -b redis-no-cluster
cd redis-cluster-example
```

Customize anything you want then copy the files to `/etc/redis/` and `/var/lib/redis/`

```bash
sudo cp -r * /etc/redis/
sudo cp -r * /var/lib/redis/
```

Create a redis user and a redis group for the Redis Server services and give them the correct permissions by running the following commands:

```bash
sudo chown redis:redis -R /var/lib/redis
sudo chmod 770 -R /var/lib/redis
sudo chown redis:redis -R /etc/redis
```

Now, we will have create the `systemd` services.
Let's start by giving `create.sh` execution permissions

```bash
chmod +x create.sh
```

and run it

```bash
sudo sh ./create.sh
```

Now let's enable all the services

```bash
chmod +x enable.sh # give execution permissions
sudo sh ./enable.sh # enable the services
```

now start all the services

```bash
chmod +x start.sh # give execution permissions
sudo sh ./start.sh # start the services
```

to check the status of any services

```bash
systemctl status redis_service_6379

#or to see all
systemctl list-units --type=service
```

to get logs:

```
sudo tail -n 100 /var/log/redis/redis_service_6379.log
```

To reinstall

```bash
sudo apt-get update
sudo apt-get install redis-server
```

### Commands

```bash
# start
sudo systemctl start redis_service_6379.service

# stop
sudo systemctl stop redis_service_6379.service

# restart
sudo systemctl restart redis_service_6379.service

# enable
sudo systemctl enable redis_service_6379.service

# disable
sudo systemctl disable redis_service_6379.service

# status
systemctl status redis_service_6379.service
```

### Mass Commands

```bash
sudo sh create.sh # create all services
sudo sh start.sh # start all services
sudo sh stop.sh # stop all services
sudo sh restart.sh # restart all services
sudo sh enable.sh # enable all services
```

### Errors

- If you get cluster formatting errors use

```bash
tr -d '\r' < filename.sh > filename_fixed.sh
```

and then run `./filename_fixed.sh` instead.
