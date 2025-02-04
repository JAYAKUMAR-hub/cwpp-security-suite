#!/bin/bash

# CWPP Security Suite Setup Script

set -e

# Check prerequisites
check_prerequisites() {
    echo "Checking system prerequisites..."
    
    # Check Kubernetes
    if ! command -v kubectl &> /dev/null; then
        echo "kubectl is not installed. Please install Kubernetes client."
        exit 1
    fi

    # Check Docker
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install Docker."
        exit 1
    fi

    # Check Python
    if ! command -v python3 &> /dev/null; then
        echo "Python 3 is not installed. Please install Python."
        exit 1
    fi
}

# Install dependencies
install_dependencies() {
    echo "Installing required dependencies..."
    pip3 install -r requirements.txt
}

# Setup Falco
setup_falco() {
    echo "Setting up Falco..."
    helm repo add falcosecurity https://falcosecurity.github.io/charts
    helm install falco falcosecurity/falco -n security --create-namespace
}

# Setup Tracee
setup_tracee() {
    echo "Setting up Tracee..."
    kubectl apply -f configs/tracee/deployment.yaml
}

# Setup Tetragon
setup_tetragon() {
    echo "Setting up Tetragon..."
    kubectl apply -f configs/tetragon/deployment.yaml
}

# Main setup function
main() {
    check_prerequisites
    install_dependencies
    setup_falco
    setup_tracee
    setup_tetragon

    echo "CWPP Security Suite setup completed successfully!"
}

main