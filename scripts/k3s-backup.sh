#!/bin/bash

DATE=$(date +%F-%H%M)

mkdir -p ~/backups/k3s

sudo cp /var/lib/rancher/k3s/server/db/state.db \
~/backups/k3s/state-$DATE.db

sudo tar -czf ~/backups/k3s/manifests-$DATE.tar.gz \
/var/lib/rancher/k3s/server/manifests

tar -czf ~/backups/k3s/infra-git-$DATE.tar.gz \
~/infra-git

sudo chown -R ravi:ravi ~/backups/k3s

find ~/backups/k3s -type f -mtime +7 -delete
