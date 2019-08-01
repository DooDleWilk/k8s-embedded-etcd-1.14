#!/bin/bash
source nodes.sh

ssh -t root@${ETCD1_IP} /etcdctl.sh member list > bootstrap_config/etcd_members.txt
awk -F: '{print $1}' bootstrap_config/etcd_members.txt

#ssh -t root@${ETCD1_IP} /etcdctl.sh member remove

