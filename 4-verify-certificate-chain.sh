#!/bin/sh


pushd certs/

openssl verify -CAfile rootCA.crt server.crt

popd
