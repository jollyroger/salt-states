# Configuration file for salt-minion. Some workaround is present here:
# currently salt-minion cannot restart itself, thus it's impossible to restart
# minion after valuable changes like changing config file.

/etc/salt/minion.d:
  file.directory:
    - user: root
    - group: root
    - mode: 0755
    - require:
      - pkg: salt-minion

salt-minion:
  service:
    - running
    - enable: True
  pkg.installed:
    - names:
      - salt-minion
      - at
  cmd.wait:
    - name: "echo 'invoke-rc.d salt-minion restart'|at now + 1 min"
    - watch:
      - pkg: salt-minion
      - file: /etc/salt/minion
      - file: /etc/salt/minion.d
    - require:
      - pkg: at
  file.managed:
    - name: /etc/salt/minion
    - owner: root
    - group: root
    - mode: 0644
    - source: salt://minion/minion.template
    - template: jinja
    - context:
      master: salt.example.com
      state_verbose: False
