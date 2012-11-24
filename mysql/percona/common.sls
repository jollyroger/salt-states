include:
  - mysql.common
  - apt.percona

extend:
  mysql-common:
    pkg.installed:
      - name:
        - percona-server-common
    file.directory:
      - require:
        - pkg: percona-server-common
