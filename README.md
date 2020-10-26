# k8s-tf

A dockerized terraform runtime configured for k8s+helm.

# Usage

## Dev local

* Start minikube:
  ```
  minikube start --kubernetes-version=v1.19.2 --driver=virtualbox
  ```

* Run targets, e.g.:
  ```
  make plan
  ```