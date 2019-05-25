#!/bin/zsh

#Sync opt signals
rsync -za --delete ali@storage:/storage/lib/signals/mesbah/ /opt/signals/

#sync external git
for i in /data/git-sync/*;do pushd $i; git fetch --quiet origin ;git push --quiet work; popd;done

#Update all server's packages
cd /home/ali/ansible && ansible-playbook update_packages.yaml
