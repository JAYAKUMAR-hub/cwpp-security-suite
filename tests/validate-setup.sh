#!/bin/bash

# Validate CWPP Security Suite Setup

validate_falco() {
    kubectl get pods -n security | grep falco
}

validate_tracee() {
    kubectl get pods -n security | grep tracee
}

validate_tetragon() {
    kubectl get pods -n security | grep tetragon
}

main() {
    echo "Validating CWPP Security Suite Installation..."
    
    validate_falco
    validate_tracee
    validate_tetragon
}

main