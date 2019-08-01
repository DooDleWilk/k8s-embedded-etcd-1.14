#!/bin/bash
source nodes.sh

ssh root@${MASTER1_IP} bootstrap-scripts/reset.sh

cat <<EOF >bootstrap-config/master-${K8S_MINOR}.yaml
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: ${K8S_PATCH}
apiServer:
  certSANs:
  - "${HAPROXY_IP}"
controlPlaneEndpoint: "${HAPROXY_IP}:6443"
networking:
    podSubnet: "${POD_CIDR}"
EOF

ssh root@${MASTER1_IP} -- rm -rf bootstrap-scripts
ssh root@${MASTER1_IP} -- rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${MASTER1_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${MASTER1_IP}:bootstrap-config

ssh root@${MASTER1_IP} -- kubeadm init --config bootstrap-config/master-${K8S_MINOR}.yaml
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods --all-namespaces
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f ${CNI_MANIFEST}
sleep 30
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods --all-namespaces
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes