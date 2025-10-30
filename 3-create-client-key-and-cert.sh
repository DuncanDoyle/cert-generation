#!/bin/sh

pushd certs/

# Generate a private key for the client
openssl genrsa -out client.key 2048

# Create a certificate signing request (CSR)
openssl req -new -key client.key -out client.csr \
  -subj "/C=US/ST=CA/O=Solo.io/CN=client"

# Use the root CA to sign the client CSR
openssl x509 -req \
  -in client.csr \
  -CA rootCA.crt -CAkey rootCA.key -CAcreateserial \
  -out client.crt -days 365 -sha256

  popd

##########################################################################################
# You now have:
#
# client.key — private key for your client
#
# client.crt — certificate signed by your root CA
#
# rootCA.crt — the CA’s certificate (trust chain)
##########################################################################################