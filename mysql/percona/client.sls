include :
  - mysql.percona.common
  - mysql.client

extend:
  mysql-client:
    pkg.installed:
      - name: percona-server-client
