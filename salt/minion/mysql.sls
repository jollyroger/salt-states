include: 
  - salt.minion

salt-mysql-module:
  pkg.installed:
    - name: python-mysqldb
  file.managed:
    - name: /etc/salt/minion.d/mysql.conf
    - source: salt://salt/minion/salt_mysql.conf
    - user: root
    - group: root
    - mode: 0644
    - require_in: 
      - file: /etc/salt/minion.d
    - require:
      - pkg: python-mysqldb
    - watch_in:
      - cmd: restart_minion
