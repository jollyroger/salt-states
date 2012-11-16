/etc/apt/preferences:
  file:
    - absent

/etc/apt/preferences.d:
  file.directory:
    - mode: 0755
    - user: root
    - group: root
    - clean: True
