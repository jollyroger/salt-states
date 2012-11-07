# Salt state for management /etc/motd. Requires package lsb-release to detect
# exact distribution. If required packages cannot be found, only required
# packages are installed. In this case another run of state.highstate is 
# required to actually perform actions described in this state.


{% if grains.lsb_release is not defined %}
lsb-release:
  pkg:
    - installed

{% else %}

initscripts:
  pkg:
    - installed

/etc/motd{%- if grains['lsb_codename'] == "squeeze" -%}.tail{%- endif %}:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://motd/motd.template
    - template: jinja
    - require:
      - pkg: initscripts

{% if grains['lsb_codename'] == "squeeze" %}
/etc/motd:
  file.symlink:
    - name: /etc/motd
    - target: /var/run/motd
    - force: True

invoke-rc.d bootlogs start:
  cmd:
    - wait
    - watch:
      - pkg: initscripts
      - file: /etc/motd
      - file: /etc/motd.tail
{% endif %}

{% endif %}
