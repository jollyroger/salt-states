include:
  - minion

salt-mysql-module:
  pkg.installed:
    - name: python-mysqldb
  file.managed:
    - name: /etc/salt/minion.d/mysql.conf
    - source: salt://mysql/salt_mysql.conf
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: python-mysqldb
    - watch_in:
      - cmd: salt-minion
