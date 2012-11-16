# ex: set ft=yaml:
netselect-apt:
  pkg:
    - installed

wget:
  pkg:
    - installed

/etc/apt/sources.list:
  file:
    - absent

{% set mirrors_list = "/etc/apt/mirrors.list" %}
{% set mirrors_list_url = "http://www.debian.org/mirror/list-full" %}
{% set sources_list = "/etc/apt/sources.list.d/debian.list" %}

{{ mirrors_list }}:
  file.managed:
    - name: {{ mirrors_list }}
    - mode: 0644
    - user: root
    - group: root
    - require: 
      - cmd: {{ mirrors_list }}
  cmd:
    - name: "wget -O {{ mirrors_list }} {{ mirrors_list_url }}"
    - run
    - onlyif: "[ ! -e {{ mirrors_list }} ]"
    - require:
      - pkg: wget


{{ sources_list }}:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - require:
      - cmd: {{ sources_list }}
  cmd:
    - name: "netselect-apt -i {{ mirrors_list }} -o {{ sources_list }} {{ grains['lsb_codename'] }}"
    - run
    - onlyif: "[ ! -e {{ sources_list }} ]"
    - watch: 
      # These should be some watch on cmd rather then on file since file is
      # generated by some command and thus salt doesn't pass changes to other
      # nodes that depend on it
      - file: {{ mirrors_list }}
    - require:
      - pkg: netselect-apt
      - file: {{ mirrors_list }}