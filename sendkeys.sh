#!/bin/bash

source nodes.sh


ssh root@${MASTER2_IP} rm /etc/kubernetes/pki/api*
ssh root@${MASTER2_IP} rm /etc/kubernetes/pki/front-proxy-client*
ssh root@${MASTER2_IP} rm /etc/kubernetes/pki/etcd/health*
ssh root@${MASTER2_IP} rm /etc/kubernetes/pki/etcd/peer*
ssh root@${MASTER2_IP} rm /etc/kubernetes/pki/etcd/server*

ssh root@${MASTER3_IP} rm -rf /etc/kubernetes/pki
scp -r /etc/kubernetes/pki/ root@${MASTER3_IP}:/etc/kubernetes/
scp -r /etc/kubernetes/admin.conf root@${MASTER3_IP}:/etc/kubernetes/admin.conf
ssh root@${MASTER3_IP} rm /etc/kubernetes/pki/api*
ssh root@${MASTER3_IP} rm /etc/kubernetes/pki/front-proxy-client*
ssh root@${MASTER3_IP} rm /etc/kubernetes/pki/etcd/health*
ssh root@${MASTER3_IP} rm /etc/kubernetes/pki/etcd/peer*
ssh root@${MASTER3_IP} rm /etc/kubernetes/pki/etcd/server*