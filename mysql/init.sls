# Basic mysql management module. Defaults to installing both client and server
# for three different package providers: debian (as a basis), dotdeb and
# percona.


include:
  - salt.minion.mysql
  - mysql.{{ pillar["mysql-provider"]|d("debian") }}
  #- mysql.config
