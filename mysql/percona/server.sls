include:
  - mysql.percona.common
  - mysql.server

extend:
  mysql-server:
    pkg.installed:
      - name: percona-server-server
