#!/usr/bin/env bash

set -ex

value_or_default(){
    value=$1
    default=$2

    if [[ -z "$value" ]]; then
        echo ${default}
    else
        echo ${value}
    fi
}

build_image(){
    service_name=$1
    image_name=${2:-"sepractices/eng-lab-$service_name"}
    dockerfile=${3:-Dockerfile}

    pushd "$service_name"
    docker build -t "$image_name" -f "$dockerfile" .
    popd

    # docker push "$image_name:latest"
}

build_image account-service
build_image balance-service "sepractices/eng-lab-balance-service" Dockerfile.app
build_image balance-service "sepractices/eng-lab-balance-worker" Dockerfile.worker
build_image cashier-service
build_image customer-service
build_image transaction-service
