#!/usr/bin/env bash

# thanks: https://alexanderzeitler.com/articles/Fixing-Chrome-missing_subjectAltName-selfsigned-cert-openssl/

openssl genrsa -des3 -out ~/.ssl/rootCA.key 2048

openssl req \
  -x509 \
  -new \
  -nodes \
  -key ~/.ssl/rootCA.key \
  -sha256 \
  -days 1024 \
  -out ~/.ssl/rootCA.pem
