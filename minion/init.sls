salt-minion:
  pkg.installed:
    - names:
      - salt-minion
      - at
  cmd.wait:
    - name: "echo 'invoke-rc.d salt-minion restart'|at now + 1 min"
    - watch:
      - pkg: salt-minion
      - file: /etc/salt/minion
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
