lsb-release:
  pkg:
    - installed

/etc/apt/sources.list.d:
  file.directory:
    - mode: 0755
    - user: root
    - group: root
    - clean: True

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
  cmd.wait:
   - name: "apt-get update"
   - watch:
     - file: /etc/apt/sources.list
     - file: /etc/apt/sources.list.d
