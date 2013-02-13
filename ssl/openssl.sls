openssl:
  pkg:
    - installed
  file.managed:
    - name: /etc/ssl/openssl.cnf
    - mode: 0644
    - user: root
    - group: root
    - require:
      - pkg: openssl
      - file: ssl-certificates-dirs

ssl-certificates-dirs:
  file.directory:
    - names:
      - /etc/ssl/
      - /etc/ssl/certs
    - mode: 0755
    - user: root
    - group: root
    - clean: false
    - require:
      - pkg: openssl

/etc/ssl/private:
  file.directory:
    - mode: 0700
    - user: root
    - group: root
    - clean: false
    - require:
      - pkg: openssl
