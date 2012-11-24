include:
  - mysql.percona.client
  - mysql.server

extend:
  mysql-server:
    pkg.installed:
      - name: percona-server-server
