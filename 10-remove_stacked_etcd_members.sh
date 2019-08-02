#!/bin/bash
source nodes.sh

ssh -t root@${ETCD1_IP} /etcdctl.sh member remove $(ssh -t root@${ETCD1_IP} /etcdctl.sh member list | grep ${MASTER1_HOST} | awk -F: '{print $1}')
ssh -t root@${ETCD1_IP} /etcdctl.sh member remove $(ssh -t root@${ETCD1_IP} /etcdctl.sh member list | grep ${MASTER2_HOST} | awk -F: '{print $1}')
ssh -t root@${ETCD1_IP} /etcdctl.sh member remove $(ssh -t root@${ETCD1_IP} /etcdctl.sh member list | grep ${MASTER3_HOST} | awk -F: '{print $1}')

ssh root@${MASTER1_IP} rm /etc/kubernetes/manifests/etcd.yaml
ssh root@${MASTER2_IP} rm /etc/kubernetes/manifests/etcd.yaml
ssh root@${MASTER3_IP} rm /etc/kubernetes/manifests/etcd.yaml

