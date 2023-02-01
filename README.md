# Redis with RedisJSON clustering made easy

Before starting, this uses Redis JSON, you can edit the `cluster.sh` file to remove the module loading.

So when u pull this repo, cd to the repo then run

```bash
git clone https://github.com/RedisJSON/RedisJSON
```

`cd` to the `RedisJSON` folder and run

```bash
cargo build --release
```

Then `cd` back `cd ..`

- Create cluster nodes with `./cluster.sh` script.
- Then we need to join the nodes together with this command by opening another terminal and running

```console
redis-cli --cluster create \
  127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 \
  127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006 
  --cluster-replicas 1
```
*note: if you want up to 12 nodes go to cluster.sh and uncoment the nodes you want and add them in the above command*

- If you encounter setup errors just stop the session with

```
tmux kill-session -t redis-cluster
```

and then run `./cluster.sh` again.

- Make sure you add permissions to your sh file

```bash
chmod +x cluster.sh
```
