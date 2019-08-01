#!/bin/bash

./0-reset_all.sh

./1-launch_haproxy.sh

./2-install_docker_and_kube_components.sh

./3-init_master.sh

./4-join_masters.sh

./5-join_workers.sh
