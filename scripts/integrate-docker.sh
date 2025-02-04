#!/bin/bash

# Kubernetes Integration Script

deploy_security_namespace() {
    kubectl create namespace security || true
}

deploy_cwpp_tools() {
    # Deploy Falco
    kubectl apply -f ../configs/falco/deployment.yaml -n security

    # Deploy Tracee
    kubectl apply -f ../configs/tracee/deployment.yaml -n security

    # Deploy Tetragon
    kubectl apply -f ../configs/tetragon/deployment.yaml -n security
}

configure_network_policies() {
    kubectl apply -f ../configs/falco/network-policies.yaml -n security
    kubectl apply -f ../configs/tracee/network-policies.yaml -n security
    kubectl apply -f ../configs/tetragon/network-policies.yaml -n security
}

main() {
    deploy_security_namespace
    deploy_cwpp_tools
    configure_network_policies
    
    echo "CWPP tools deployed successfully in Kubernetes cluster"
}

main