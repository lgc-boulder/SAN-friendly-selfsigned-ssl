# SAN-based SSL certificate tools

## Steps to use these tools  

1. (probably optional) update SAN-friendly_server.csr.cnf line 13 with your email address.

2.  Ensure you have directory at `~/.ssl`

3.  Run `create_root-certificate-authority.bash`
4.  Run `create_self-signed-certificate.bash`

5.  (example) Specify the resulting cert file locations when starting your server.  In my case I'm using thin, a ruby server.  My start command looks like this:

```
bundle exec thin start -p $PORT_HTTPS --ssl --ssl-key-file $SSL_KEY_FILE --ssl-cert-file $SSL_CERT_FILE --rackup config.ru
```

And those env vars SSL_KEY_FILE and SSL_CERT_FILE are set to `~/.ssl/SAN-friendly_server.key` and `~/.ssl/SAN-friendly_server.crt`, respectively.

## Thanks

All this code is from Alexander Zeitler's blog post here:

https://alexanderzeitler.com/articles/Fixing-Chrome-missing_subjectAltName-selfsigned-cert-openssl/

