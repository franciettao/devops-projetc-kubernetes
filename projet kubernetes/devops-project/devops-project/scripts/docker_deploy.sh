# scripts/kubernetes_setup.sh
#!/bin/bash

# Define the Kubernetes context and namespace
KUBE_CONTEXT="my-kube-context"
KUBE_NAMESPACE="my-kube-namespace"

# Define the Kubernetes config file path
KUBE_CONFIG="/path/to/kubeconfig"

# Load the Kubernetes config
load_kube_config() {
  if [ ! -f "$KUBE_CONFIG" ]; then
    echo "Kubernetes config file not found: $KUBE_CONFIG"
    exit 1
  fi

  export KUBECONFIG="$KUBE_CONFIG"

  if [ "$(kubectl config current-context)" != "$KUBE_CONTEXT" ]; then
    echo "Kubernetes context not set to $KUBE_CONTEXT"
    exit 1
  fi

  if [ "$(kubectl get namespace --output=jsonpath='{.metadata.name}')" != "$KUBE_NAMESPACE" ]; then
    echo "Kubernetes namespace not set to $KUBE_NAMESPACE"
    exit 1
  fi
}

# Create a Kubernetes namespace
create_namespace() {
  if [ "$(kubectl get namespace "$KUBE_NAMESPACE" --output=jsonpath='{.metadata.name}')" != "$KUBE_NAMESPACE" ]; then
    kubectl create namespace "$KUBE_NAMESPACE"
  fi
}

# Deploy a Kubernetes manifest
deploy_manifest() {
  local MANIFEST_FILE="$1"

  if [ ! -f "$MANIFEST_FILE" ]; then
    echo "Manifest file not found: $MANIFEST_FILE"
    exit 1
  fi

  kubectl apply -f "$MANIFEST_FILE"
}

# Main function
main() {
  load_kube_config
  create_namespace
  deploy_manifest "/path/to/manifest.yaml"
}

# Call the main function
main