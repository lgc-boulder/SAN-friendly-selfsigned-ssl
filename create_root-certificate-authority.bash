#!/usr/bin/env bash

# thanks: https://alexanderzeitler.com/articles/Fixing-Chrome-missing_subjectAltName-selfsigned-cert-openssl/

echo "Where to output files?"
echo "1.  ~/.ssl/"
echo "2.  current directory"

output_dir=0

read output_selection

if [ "$output_selection" -eq 1 ]; then
  output_dir="~/.ssl"
elif [ $output_selection -eq 2 ]; then
  output_dir=`pwd`
else
  echo "you must enter 1 or 2"
  exit 1
fi

openssl genrsa -des3 -out "${output_dir}/rootCA.key" 2048

openssl req \
  -x509 \
  -new \
  -nodes \
  -key "${output_dir}/rootCA.key" \
  -sha256 \
  -days 1024 \
  -out "${output_dir}/rootCA.pem"
