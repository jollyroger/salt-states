include:
  - apt.sources

insert_nginx_key:
  cmd.wait:
    - name: apt-key adv --keyserver keys.gnupg.net --recv-keys 7BD9BF62
    - unless: apt-key adv --list-keys 7BD9BF62
    - order: 10
    - watch:
      - file: /etc/apt/sources.list.d/nginx.org.list


/etc/apt/sources.list.d/nginx.org.list:
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
          url: http://nginx.org/packages/debian/
