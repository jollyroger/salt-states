include:
  - ssl.openssl

ca-certificates:
  pkg:
    - installed
  file.managed:
    - names:
      - /etc/ca-certificates.conf
      - /etc/ssl/certs/ca-certificates.crt
    - mode: 0644
    - user: root
    - group: root
    - require:
      - pkg: ca-certificates


ca-certificates-dirs:
  file.directory:
    - names:
      - /etc/ca-certificates
      - /etc/ca-certificates/update.d
    - mode: 0755
    - user: root
    - group: root
    - clean: false
    - require:
      - pkg: ca-certificates

/usr/local/share/ca-certificates:
  file.directory:
    - require:
      - pkg: ca-certificates
    - clean: true

/usr/sbin/update-ca-certificates:
  cmd.wait:
    - watch:
      - file: /usr/local/share/ca-certificates
