# ex: set ft=yaml:

ntp:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: ntp
      - file: /etc/ntp.conf
      - user: ntp
      - group: ntp
  user.present:
    - system: true
    - gid: {{ salt['file.group_to_gid']('ntp') }}
    - home: /home/ntp
    - shell: /bin/false
    - require:
      - group: ntp
      - pkg: ntp
  group.present:
    - require:
      - pkg: ntp

/etc/ntp.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: ntp
