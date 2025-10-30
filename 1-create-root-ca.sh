#!/bin/sh

# Create a directory to work in
mkdir -p certs

pushd certs/

# Generate a private key for the root CA
openssl genrsa -out rootCA.key 4096

# Generate a self-signed certificate for the root CA (valid 10 years)
openssl req -x509 -new -nodes \
  -key rootCA.key \
  -sha256 \
  -days 3650 \
  -out rootCA.crt \
  -subj "/C=US/ST=CA/L=SanFrancisco/O=ExampleOrg/CN=example-root-ca"

popd

################################################################################################
# You now have:
#
# rootCA.key — the private key of your CA
#
# rootCA.crt — the public cert of your CA
################################################################################################