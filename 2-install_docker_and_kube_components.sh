#!/bin/bash
source nodes.sh

scp -r bootstrap-scripts/install_docker.sh root@${MASTER1_IP}:/root/install_docker.sh
scp -r bootstrap-scripts/install_kubeadm.sh root@${MASTER1_IP}:/root/install_kubeadm.sh
ssh root@${MASTER1_IP} -- /root/install_docker.sh
ssh root@${MASTER1_IP} -- /root/install_kubeadm.sh
ssh root@${MASTER1_IP} -- rm /root/install_docker.sh
ssh root@${MASTER1_IP} -- rm /root/install_kubeadm.sh

scp -r bootstrap-scripts/install_docker.sh root@${MASTER2_IP}:/root/install_docker.sh
scp -r bootstrap-scripts/install_kubeadm.sh root@${MASTER2_IP}:/root/install_kubeadm.sh
ssh root@${MASTER2_IP} -- /root/install_docker.sh
ssh root@${MASTER2_IP} -- /root/install_kubeadm.sh
ssh root@${MASTER2_IP} -- rm /root/install_docker.sh
ssh root@${MASTER2_IP} -- rm /root/install_kubeadm.sh

scp -r bootstrap-scripts/install_docker.sh root@${MASTER3_IP}:/root/install_docker.sh
scp -r bootstrap-scripts/install_kubeadm.sh root@${MASTER3_IP}:/root/install_kubeadm.sh
ssh root@${MASTER3_IP} -- /root/install_docker.sh
ssh root@${MASTER3_IP} -- /root/install_kubeadm.sh
ssh root@${MASTER3_IP} -- rm /root/install_docker.sh
ssh root@${MASTER3_IP} -- rm /root/install_kubeadm.sh

scp -r bootstrap-scripts/install_docker.sh root@${WORKER1_IP}:/root/install_docker.sh
scp -r bootstrap-scripts/install_kubeadm.sh root@${WORKER1_IP}:/root/install_kubeadm.sh
ssh root@${WORKER1_IP} -- /root/install_docker.sh
ssh root@${WORKER1_IP} -- /root/install_kubeadm.sh
ssh root@${WORKER1_IP} -- rm /root/install_docker.sh
ssh root@${WORKER1_IP} -- rm /root/install_kubeadm.sh

scp -r bootstrap-scripts/install_docker.sh root@${WORKER2_IP}:/root/install_docker.sh
scp -r bootstrap-scripts/install_kubeadm.sh root@${WORKER2_IP}:/root/install_kubeadm.sh
ssh root@${WORKER2_IP} -- /root/install_docker.sh
ssh root@${WORKER2_IP} -- /root/install_kubeadm.sh
ssh root@${WORKER2_IP} -- rm /root/install_docker.sh
ssh root@${WORKER2_IP} -- rm /root/install_kubeadm.sh

scp -r bootstrap-scripts/install_docker.sh root@${WORKER3_IP}:/root/install_docker.sh
scp -r bootstrap-scripts/install_kubeadm.sh root@${WORKER3_IP}:/root/install_kubeadm.sh
ssh root@${WORKER3_IP} -- /root/install_docker.sh
ssh root@${WORKER3_IP} -- /root/install_kubeadm.sh
ssh root@${WORKER3_IP} -- rm /root/install_docker.sh
ssh root@${WORKER3_IP} -- rm /root/install_kubeadm.sh

