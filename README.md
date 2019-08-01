# cork-k8s-scripts

## Setup

Copy nodes.sh.example to node.sh and add your inventory

# generate ssh keys

```
ssh-keygen
```

# authorize your key

```
./ssh-copy-id.sh
```

## reset all nodes
```
./0-reset_all.sh
```

## launch haproxy
```
./1-launch_haproxy.sh
```