# ex: set ft=yaml

base:
  '*':
    - salt.minion
    - apt
    - ntp
    - motd
    - vim
    {% for module in pillar["modules"]|d([]) %}
    - {{ module }}
    {% endfor %}
