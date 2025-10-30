#!/bin/sh

kubectl create secret generic api-example-com \
  --from-file=tls.key=certs/server.key \
  --from-file=tls.crt=certs/server.crt \
  --from-file=ca.crt=certs/rootCA.crt \
  --type=kubernetes.io/tls \
  -n gloo-system

# kubectl create secret generic api-example-com \
#   --from-file=tls.key=certs/server.key \
#   --from-file=tls.crt=certs/server.crt \
#   --type=kubernetes.io/tls \
#   -n gloo-system