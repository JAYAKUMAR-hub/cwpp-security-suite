#!/bin/bash

# Performance Monitoring Script for CWPP Tools

monitor_falco() {
    kubectl top pods -n security | grep falco
}

monitor_tracee() {
    kubectl top pods -n security | grep tracee
}

monitor_tetragon() {
    kubectl top pods -n security | grep tetragon
}

main() {
    echo "=== Falco Performance ==="
    monitor_falco
    
    echo -e "\n=== Tracee Performance ==="
    monitor_tracee
    
    echo -e "\n=== Tetragon Performance ==="
    monitor_tetragon
}

main