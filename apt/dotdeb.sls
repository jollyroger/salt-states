include:
  - apt.sources

extend:
  /etc/apt/sources.list.d:
    file:
      - require:
        - file: /etc/apt/sources.list.d/dotdeb.org.list
    cmd.wait:
      - watch:
        - file: /etc/apt/sources.list.d/dotdeb.org.list


/etc/apt/sources.list.d/dotdeb.org.list:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - source: salt://apt/sources.list
    - context:
      repositories:
        - name: squeeze
          url: http://packages.dotdeb.org
          components: [all]


insert_dotdeb_key:
  cmd.wait:
    - name: apt-key adv --keyserver keys.gnupg.net --recv-keys 89DF5277
    - unless: apt-key adv --list-keys 89DF5277
    - watch:
      - file: /etc/apt/sources.list.d/dotdeb.org.list
