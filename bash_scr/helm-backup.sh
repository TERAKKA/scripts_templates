#!/bin/bash
for ns in $(kubectl get ns --no-headers | cut -d " " -f1); do
  helm backup $ns
done