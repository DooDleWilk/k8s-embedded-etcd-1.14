#!/bin/bash
source nodes.sh

scp root@${MASTER1_IP}:/etc/kubernetes/manifests/kube-apiserver.yaml bootstrap-config/master1-kube-apiserver.yaml
scp root@${MASTER2_IP}:/etc/kubernetes/manifests/kube-apiserver.yaml bootstrap-config/master2-kube-apiserver.yaml
scp root@${MASTER3_IP}:/etc/kubernetes/manifests/kube-apiserver.yaml bootstrap-config/master3-kube-apiserver.yaml

sed -i "s#etcd-servers=https://127.0.0.1:2379#etcd-servers=https://${ETCD1_IP}:2379,https://${ETCD3_IP}:2379,https://${ETCD2_IP}:2379#g" bootstrap-config/master1-kube-apiserver.yaml
sed -i "s#etcd-servers=https://127.0.0.1:2379#etcd-servers=https://${ETCD1_IP}:2379,https://${ETCD3_IP}:2379,https://${ETCD2_IP}:2379#g" bootstrap-config/master2-kube-apiserver.yaml
sed -i "s#etcd-servers=https://127.0.0.1:2379#etcd-servers=https://${ETCD1_IP}:2379,https://${ETCD3_IP}:2379,https://${ETCD2_IP}:2379#g" bootstrap-config/master3-kube-apiserver.yaml

scp bootstrap-config/master1-kube-apiserver.yaml root@${MASTER1_IP}:/etc/kubernetes/manifests/kube-apiserver.yaml
scp bootstrap-config/master2-kube-apiserver.yaml root@${MASTER2_IP}:/etc/kubernetes/manifests/kube-apiserver.yaml
scp bootstrap-config/master3-kube-apiserver.yaml root@${MASTER3_IP}:/etc/kubernetes/manifests/kube-apiserver.yaml

scp root@${ETCD1_IP}:/etc/kubernetes/manifests/etcd.yaml bootstrap-config/etcd1-etcd.yaml
scp root@${ETCD2_IP}:/etc/kubernetes/manifests/etcd.yaml bootstrap-config/etcd2-etcd.yaml
scp root@${ETCD3_IP}:/etc/kubernetes/manifests/etcd.yaml bootstrap-config/etcd3-etcd.yaml

# TO IMPROVE!!!
sed -i "s#initial-cluster=k8s-master-1=https://172.20.11.205:2380,k8s-master-2=https://172.20.11.207:2380,k8s-master-3=https://172.20.11.214:2380,k8s-etcd-1=https://172.20.11.206:2380#initial-cluster=${ETCD1_HOST}=https://${ETCD1_IP}:2380,${ETCD2_HOST}=https://${ETCD2_IP}:2380,${ETCD3_HOST}=https://${ETCD3_IP}:2380#g" bootstrap-config/etcd1-etcd.yaml
sed -i "s#initial-cluster=k8s-master-1=https://172.20.11.205:2380,k8s-master-2=https://172.20.11.207:2380,k8s-master-3=https://172.20.11.214:2380,k8s-etcd-1=https://172.20.11.206:2380,k8s-etcd-2=https://172.20.11.210:2380#initial-cluster=${ETCD1_HOST}=https://${ETCD1_IP}:2380,${ETCD2_HOST}=https://${ETCD2_IP}:2380,${ETCD3_HOST}=https://${ETCD3_IP}:2380#g" bootstrap-config/etcd1-etcd.yaml
sed -i "s#nitial-cluster=k8s-master-1=https://172.20.11.205:2380,k8s-master-2=https://172.20.11.207:2380,k8s-master-3=https://172.20.11.214:2380,k8s-etcd-1=https://172.20.11.206:2380,k8s-etcd-2=https://172.20.11.210:2380,k8s-etcd-3=https://172.20.11.213:2380#initial-cluster=${ETCD1_HOST}=https://${ETCD1_IP}:2380,${ETCD2_HOST}=https://${ETCD2_IP}:2380,${ETCD3_HOST}=https://${ETCD3_IP}:2380#g" bootstrap-config/etcd1-etcd.yaml

scp bootstrap-config/etcd1-etcd.yaml root@${ETCD1_IP}:/etc/kubernetes/manifests/etcd.yaml
scp bootstrap-config/etcd2-etcd.yaml root@${ETCD2_IP}:/etc/kubernetes/manifests/etcd.yaml
scp bootstrap-config/etcd3-etcd.yaml root@${ETCD3_IP}:/etc/kubernetes/manifests/etcd.yaml

