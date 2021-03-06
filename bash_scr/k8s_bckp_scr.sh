#!/bin/bash
# Backup certificates
sudo cp -r /etc/kubernetes/pki backup/
# etcd snapshot
sudo docker run --rm -v $(pwd)/backup:/backup \
--network host \
-v /etc/kubernetes/pki/etcd:/etc/kubernetes/pki/etcd \
--env ETCDCTL_API=3 \
k8s.gcr.io/etcd-amd64:3.2.18 \
etcdctl --endpoints=https://127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
--key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
snapshot save /backup/etcd-snapshot-latest.db