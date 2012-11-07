include:
  - minion

extend:
  salt-minion:
    pkg.installed:
      - names:
        - python-mysqldb
    cmd.wait:
      - watch:
        - pkg: python-mysqldb
    file.managed:
      - context:
        module_settings:
          - mysql:
            - default_file: /etc/mysql/debian.cnf

#mysql-server:
#  pkg:
#    - installed
#  service:
#    - name: "mysql"
#    - running
