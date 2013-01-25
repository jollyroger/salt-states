include:
  - ssl.openssl

ssl-cert:
  pkg:
    - installed
  group.present:
    - require:
      - pkg: ssl-cert
  file.present:
    - names:
      - /etc/ssl/certs/ssl-cert-snakeoil.pem
      - /etc/ssl/private/ssl-cert-snakeoil.key
    - require:
      - pkg: ssl-cert

extend:
  /etc/ssl/private:
    file.directory:
      - mode: 0710
      - user: root
      - group: ssl-cert
      - require:
        - group: ssl-cert
