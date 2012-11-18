# ex: set ft=yaml

base:
  '*':
    - salt.minion
    - apt
    - ntp
    - motd
    {% for module in pillar["modules"]|d([]) %}
    - {{ module }}
    {% endfor %}
