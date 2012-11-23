{% if grains.lsb_release is not defined %}
include:
  - salt.minion.lsb
{% else %}

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

{% set distribution = pillar.distribution|d(grains.lsb_codename)|d("stable") %}
/etc/apt/sources.list:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - template: jinja
    - source: salt://apt/sources.list
    - context:
      repositories:
      {% if pillar['repositories'] is defined %}
        {{ pillar['repositories'] }}
      {% else %}
        - name: {{ distribution }}
          components: [main, contrib, non-free]
        - name: {{ distribution }}/updates
          url: http://security.debian.org/
          components: [main, contrib, non-free]
      {% endif %}

{% endif %}
