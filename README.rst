PostgreSQL - Object-relational Database System
==============================================

`PostgreSQL`_ is a fully featured object-relational database with many
enterprise features: ACID transactions, inheritance, unicode and strong
support for the SQL-92 standard including subqueries, views, outer
joins, foreign keys, sequences and triggers. It is also highly
extensible and allows users to define internal functions in C, C++,
Java, Perl, TCL, Python, Ruby, PHP and PL/PgSQL.

In `comparison`_ with MySQL, PostgreSQL is more fully featured and
consistent, and has better support for large multi-processor
environments.

This appliance includes all the standard features in `TurnKey Core`_,
and on top of that:

- Webmin modules for configuring PostgreSQL.
- PostgreSQL is configured to listen on its default port (5432/tcp) on
  all interfaces by default, and accept connections from all hosts. In a
  production environment, it is recommended to limit incoming
  connections to specific hosts by configuring *Host* and *User* access
  in */etc/postgresql/9.1/main/pg\_hba.conf*.
- PostgreSQL password encryption enabled by default (security).
- The *postgres* user is trusted when connecting over local unix sockets
  (convenience).
- `PostGIS`_ support.

Credentials *(passwords set at first boot)*
-------------------------------------------

-  Webmin, SSH: username **root**
-  postgresql: username **postgres**


.. _PostgreSQL: http://www.postgresql.org/
.. _comparison: http://www.wikivs.com/wiki/MySQL_vs_PostgreSQL
.. _TurnKey Core: http://www.turnkeylinux.org/core
.. _PostGIS: http://postgis.refractions.net
