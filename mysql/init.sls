# Basic mysql management module. Defaults to installing both client and server
# for three different package providers: debian (as a basis), dotdeb and
# percona.

include:
  - salt.minion.mysql
  {% if pillar["mysql-provider"]|d("debian") != "debian" %}
  - {{ "mysql.%s" % pillar["mysql-provider"] }}
  {% else %}
  - mysql.common
  - mysql.client
  - mysql.server
  - mysql.config
  {% endif %}
