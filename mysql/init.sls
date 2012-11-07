include:
  - minion

python-mysqldb:
  pkg:
    - installed

extend:
  salt-minion:
    cmd.wait:
      - watch:
        - pkg: python-mysqldb
    file.managed:
      - watch:
        - pkg: python-mysqldb
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
