#!/usr/bin/env bash
set -euo pipefail

base_dir="$(cd "$(dirname "${0}")/.." && pwd)"

minikube delete
minikube start --cpus=4 --memory=8192

kubectl apply -f "$base_dir/k8s"
