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

# thanks: https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

openssl req -new \
  -sha256 \
  -nodes \
  -out "${output_dir}/SAN-friendly_server.csr" \
  -newkey rsa:2048 \
  -keyout "${output_dir}/SAN-friendly_server.key" \
  -config <( cat "${script_dir}/SAN-friendly_server.csr.cnf" )

openssl x509 -req \
  -in "${output_dir}/SAN-friendly_server.csr" \
  -CA "${output_dir}/rootCA.pem" \
  -CAkey "${output_dir}/rootCA.key" \
  -CAcreateserial \
  -out "${output_dir}/SAN-friendly_server.crt" \
  -days 500 \
  -sha256 \
  -extfile "${script_dir}/v3.ext"
