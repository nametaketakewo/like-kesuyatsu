#!/bin/bash

yum install -y postgresql-server postgresql-devel
service postgresql initdb
systemctl enable postgresql
systemctl start postgresql
su - postgres -c "
  psql -c \"UPDATE pg_database SET datistemplate=false WHERE datname='template1'\"
  psql -c \"DROP DATABASE template1\"
  psql -c \"CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8'\"
  psql -c \"UPDATE pg_database SET datistemplate=true WHERE datname='template1'\"
  createuser -d -S -R vagrant
"
