include:
  - apt.sources

insert_dotdeb_key:
  cmd.wait:
    - name: apt-key adv --keyserver keys.gnupg.net --recv-keys E9C74FEEA2098A6E
    - unless: apt-key adv --list-keys E9C74FEEA2098A6E
    - order: 10
    - watch:
      - file: /etc/apt/sources.list.d/dotdeb.org.list

/etc/apt/sources.list.d/dotdeb.org.list:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - source: salt://apt/sources.list
    - require_in:
      - file: /etc/apt/sources.list.d
    - watch_in:
      - cmd: "apt-get update"
    - context:
      repositories:
        - name: squeeze
          url: http://packages.dotdeb.org
          components: [all]
        {% if pillar['dotdeb_php54'] is defined %}
        - name: squeeze-php54
          url: http://packages.dotdeb.org
          components: [all]
        {% endif %}

