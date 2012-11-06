initscripts:
  pkg:
    - installed

motd:
  service:
    - running
    - watch:
      - pkg: initscripts
      - file: /etc/motd
  file.managed:
    - name: /etc/motd
    - user: root
    - group: root
    - mode: 0644
    - source: salt://motd/motd.template
    - template: jinja
    - require:
      - pkg: initscripts

