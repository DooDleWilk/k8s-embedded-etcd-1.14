#!/bin/bash
source nodes.sh

scp bootstrap-scripts/install_docker.sh root@${ETCD3_IP}:install_docker.sh
ssh root@${ETCD3_IP} ./install_docker.sh

scp bootstrap-scripts/install_kubeadm.sh root@${ETCD3_IP}:install_kubeadm.sh
ssh root@${ETCD3_IP} ./install_kubeadm.sh

scp bootstrap-scripts/static_kubelet.sh root@${ETCD3_IP}:static_kubelet.sh
ssh root@${ETCD3_IP} ./static_kubelet.sh

scp root@${MASTER1_IP}:/etc/kubernetes/pki/etcd/ca.crt bootstrap-config/etcd-ca.crt
scp root@${MASTER1_IP}:/etc/kubernetes/pki/etcd/ca.key bootstrap-config/etcd-ca.key

ssh root@${ETCD3_IP} mkdir -p /etc/kubernetes/pki/etcd

scp bootstrap-config/etcd-ca.crt root@${ETCD3_IP}:/etc/kubernetes/pki/etcd/ca.crt
scp bootstrap-config/etcd-ca.key root@${ETCD3_IP}:/etc/kubernetes/pki/etcd/ca.key

cat > bootstrap-config/etcd3.yaml <<ENDFILE
apiVersion: "kubeadm.k8s.io/v1beta1"
kind: ClusterConfiguration
kubernetesVersion: ${K8S_PATCH}
etcd:
    local:
        serverCertSANs:
        - "${ETCD3_IP}"
        peerCertSANs:
        - "${ETCD3_IP}"
        extraArgs:
            initial-cluster: ${MASTER1_HOST}=https://${MASTER1_IP}:2380,${MASTER2_HOST}=https://${MASTER2_IP}:2380,${MASTER3_HOST}=https://${MASTER3_IP}:2380,${ETCD1_HOST}=https://${ETCD1_IP}:2380,${ETCD2_HOST}=https://${ETCD2_IP}:2380,${ETCD3_HOST}=https://${ETCD3_IP}:2380
            initial-cluster-state: existing
            name: ${ETCD3_HOST}
            listen-peer-urls: https://${ETCD3_IP}:2380
            listen-client-urls: https://${ETCD3_IP}:2379
            advertise-client-urls: https://${ETCD3_IP}:2379
            initial-advertise-peer-urls: https://${ETCD3_IP}:2380
ENDFILE

scp bootstrap-config/etcd3.yaml root@${ETCD3_IP}:etcd.yaml

ssh root@${ETCD3_IP} "kubeadm init phase certs etcd-server --config=etcd.yaml; kubeadm init phase certs etcd-peer --config=etcd.yaml;kubeadm init phase certs etcd-healthcheck-client --config=etcd.yaml;kubeadm init phase certs apiserver-etcd-client --config=etcd.yaml"

scp bootstrap-scripts/etcdctl.sh root@${MASTER1_IP}:bootstrap-scripts/etcdctl.sh
ssh -t root@${MASTER1_IP} ./bootstrap-scripts/etcdctl.sh member add ${ETCD3_HOST} https://${ETCD3_IP}:2380
ssh -t root@${MASTER1_IP} ./bootstrap-scripts/etcdctl.sh member list

ssh root@${ETCD3_IP} "kubeadm init phase etcd local --config=etcd.yaml"

scp bootstrap-scripts/etcdctl.sh root@${ETCD3_IP}:/etcdctl.sh

ssh -t root@${ETCD3_IP} /etcdctl.sh member list

