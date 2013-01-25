# Salt state for client CA certificates management on Debian host. This
# requires an ssl-cert package installation.
#
# Usage:
#
# To get your local CA certificate become trusted on the target system, write
# the following to your .sls file:
#
# include:
#   - ssl
#
# /usr/local/share/ca-certificates/CA_DOMAIN_OR_ORGANISATION/certificate.crt:
#   - file.managed:
#     - mode: 0644
#     - user: root
#     - group: root
#     - source: salt://path/to/your/ca/certificate.crt
#     - makedirs: true
#     - require_in:
#       - file: /usr/local/share/ca-certificates
#     - watch_in:
#       - cmd: update-ca-certifiactes

include:
  - ssl.openssl
  - ssl.ssl-cert
  - ssl.ca-certificates
