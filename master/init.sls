# Configuration file for salt-minion. Some workaround is present here:
# currently salt-minion cannot restart itself, thus it's impossible to restart
# minion after valuable changes like changing config file.

/etc/salt/master.d:
  file.directory:
    - user: root
    - group: root
    - mode: 0755
    - require:
      - pkg: salt-master

salt-master:
  service:
    - running
    - enable: True
  pkg.installed:
    - names:
      - salt-master
      - at
  cmd.wait:
    - name: "echo 'invoke-rc.d salt-master restart'|at now + 1 min"
    - watch:
      - pkg: salt-master
      - file: /etc/salt/master
      - file: /etc/salt/master.d
    - require:
      - pkg: at
  file.managed:
    - name: /etc/salt/master
    - owner: root
    - group: root
    - mode: 0644
    - source: salt://master/master.template
    - template: jinja
