# kubernetes_setup.sh
#!/bin/bash
# This script sets up a Kubernetes cluster.

# Set variables
K8S_VERSION="1.21.2"
KUBELET_EXTRA_ARGS="--fail-swap-on=false"

# Install dependencies
sudo apt-get update
sudo apt-get install -y apt-transport-https curl

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Install kubeadm, kubelet, and kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubeadm=$K8S_VERSION kubelet=$K8S_VERSION kubectl=$K8S_VERSION
sudo apt-mark hold kubeadm kubelet kubectl

# Configure kubelet
sudo sed -i "s/^KUBELET_EXTRA_ARGS=.*/KUBELET_EXTRA_ARGS=$KUBELET_EXTRA_ARGS/g" /etc/default/kubelet

# Initialize Kubernetes cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel networking
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Display kubectl command to run on other nodes
echo "To join worker nodes to the cluster, run the following command on each node:"
kubeadm join --token <token> <master-ip>:<master-port> --discovery-token-ca-cert-hash sha256:<hash>

