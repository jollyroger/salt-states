# ex: set ft=yaml

base:
  '*':
    - salt.minion
    - apt
    - ntp
    - motd
    - vim
    - git
    - ssl
    {% for module in pillar["modules"]|d([]) %}
    - {{ module }}
    {% endfor %}
