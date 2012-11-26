include:
  - apt.sources
  - apt.preferences

insert_percona_key:
  cmd.wait:
    - name: apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
    - unless: apt-key adv --list-keys 1C4CBDCDCD2EFD2A
    - order: 10
    - watch:
      - file: /etc/apt/sources.list.d/percona.com.list


/etc/apt/sources.list.d/percona.com.list:
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
          url: http://repo.percona.com/apt


/etc/apt/preferences.d/percona.pref:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://apt/percona.pref
    - require_in: 
      - file: /etc/apt/preferences.d
