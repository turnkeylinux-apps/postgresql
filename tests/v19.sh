#!/bin/bash
set -euo pipefail

result=${TKL_TEST_RESULT:?}
password=${TKL_TEST_APP_PASS:?}
work=/run/tkl-v19-tests/postgresql
mkdir -p "$work"

systemctl --quiet is-active postgresql.service lighttpd.service
grep -q '\[35pgsqlpass\] successfully completed' /var/log/inithooks.log
curl -kfsS https://127.0.0.1/ | grep -Fq 'TurnKey PostgreSQL'

export PGPASSWORD=$password
psql -X -h 127.0.0.1 -U postgres -d postgres -v ON_ERROR_STOP=1 <<'SQL'
DROP DATABASE IF EXISTS tkl_v19_qa;
CREATE DATABASE tkl_v19_qa;
SQL
psql -X -h 127.0.0.1 -U postgres -d tkl_v19_qa -v ON_ERROR_STOP=1 <<'SQL'
CREATE TABLE persistence (value text NOT NULL);
INSERT INTO persistence VALUES ('postgresql-v19-persistence');
SQL
systemctl restart postgresql.service
test "$(psql -XAt -h 127.0.0.1 -U postgres -d tkl_v19_qa \
    -c 'SELECT value FROM persistence;')" = postgresql-v19-persistence
psql -X -h 127.0.0.1 -U postgres -d postgres -v ON_ERROR_STOP=1 \
    -c 'DROP DATABASE tkl_v19_qa;'

version=$(psql -XAt -h 127.0.0.1 -U postgres -d postgres \
    -c 'SHOW server_version;')
candidate=$(apt-cache policy postgresql | awk '/Candidate:/ {print $2}')
test -n "$candidate" && test "$candidate" != '(none)'
! grep -F -- "$password" /var/log/inithooks.log

cat >"$result" <<EOF
package_source=Debian Trixie PostgreSQL packages
installed_version=$version
runtime_checks=PostgreSQL and web services, seeded administrator TCP authentication, database/table create and query across restart
updater_command=apt-cache policy postgresql
updater_result=APT candidate $candidate found; installed packages unchanged
updater_channel=Debian Trixie signed APT repositories
integrity_evidence=APT candidate metadata accepted from configured signed repositories
EOF
