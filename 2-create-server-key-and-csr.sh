#!/bin/sh

pushd certs/

# Generate a private key for your server (e.g. api.example.com)
openssl genrsa -out server.key 2048

# Generate a Certificate Signing Request (CSR)
openssl req -new -key server.key -out server.csr \
  -subj "/C=US/ST=CA/L=SanFrancisco/O=ExampleOrg/CN=api.example.com"

# Sign the cert with the rootCa

# Create an extfile for Subject Alternative Names (SANs)
cat > server.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = api.example.com
DNS.2 = localhost
EOF

# Use the CA to sign the server certificate
openssl x509 -req \
  -in server.csr \
  -CA rootCA.crt \
  -CAkey rootCA.key \
  -CAcreateserial \
  -out server.crt \
  -days 365 \
  -sha256 \
  -extfile server.ext

popd

##########################################################################################
# You now have:
#
# server.key — private key for your service
#
# server.crt — certificate signed by your root CA
#
# rootCA.crt — the CA’s certificate (trust chain)
##########################################################################################