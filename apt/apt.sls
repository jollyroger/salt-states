/etc/apt/apt.conf:
  file:
    - absent

/etc/apt/apt.conf.d:
  file.directory:
    - mode: 0755
    - user: root
    - group: root
    - clean: False

/etc/apt/apt.conf.d/02recommends:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - source: salt://apt/apt-recommends.conf

/etc/apt/apt.conf.d/99release:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - source: salt://apt/apt-release.conf
    - context:
      release_name: {{ grains.lsb_codename|d("stable") }}

apt-get dist-upgrade:
  cmd.wait:
   - watch:
     - file: /etc/apt/apt.conf.d/99release
