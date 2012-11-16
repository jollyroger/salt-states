lsb-release:
  pkg:
    - installed

/etc/apt/sources.list.d:
  file.directory:
    - mode: 0755
    - user: root
    - group: root
    - clean: True

apt-get update:
  cmd.wait:
   - order: 20
   - watch:
     - file: /etc/apt/sources.list
     - file: /etc/apt/sources.list.d

/etc/apt/sources.list:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - source: salt://apt/sources.list
    - context:
      repositories:
        - name: {{ grains.lsb_codename|d("stable") }}
          components: [main, contrib, non-free]
        - name: {{ grains.lsb_codename|d("stable") }}/updates
          url: http://security.debian.org/
          components: [main, contrib, non-free]
