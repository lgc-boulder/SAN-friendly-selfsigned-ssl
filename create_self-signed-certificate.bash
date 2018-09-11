#!/usr/bin/env bash

# thanks: https://alexanderzeitler.com/articles/Fixing-Chrome-missing_subjectAltName-selfsigned-cert-openssl/

openssl req -new \
  -sha256 \
  -nodes \
  -out ~/.ssl/SAN-friendly_server.csr \
  -newkey rsa:2048 \
  -keyout ~/.ssl/SAN-friendly_server.key \
  -config <( cat SAN-friendly_server.csr.cnf )

openssl x509 -req \
  -in ~/.ssl/SAN-friendly_server.csr \
  -CA ~/.ssl/rootCA.pem \
  -CAkey ~/.ssl/rootCA.key \
  -CAcreateserial \
  -out ~/.ssl/SAN-friendly_server.crt \
  -days 500 \
  -sha256 \
  -extfile v3.ext
