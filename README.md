### Symmetricds test configuration

### Getting started
- clone the repo `git clone https://github.com/andy-shi88/symmetricds-configuration-example.git`

#### for h2 source
- get to the project where your h2 file reside and run them in server mode by `java -cp "lib/h2*:lib/*" org.h2.tools.Console -tcpAllowOthers -baseDir eqh_test_db`
- open `engines/store-001.properties` and set `db.user`, `db.password` and `db.url` to your local setting [here we are using `postgres`]
- run `bin/symadmin --engine corp-000 create-sym-tables` to initialize the configuration tables.
- run `cd samples && ../bin/dbimport --engine corp-000 initialize_link.sql` to initialize the basic configuration to our `corp-000` so it links to `store-001.properties`.
- finally run `bin/sym` at root directory.

now if you insert to `account` table, the postgres will sync.

#### note
- if you get `org.h2.jdbc.JdbcSQLException: Connection is broken: "unexpected status 16777216" [90067-176]`, most likely it's caused by different version of `h2 jar` between your java project and the symmetricds, just copy the jar so they are the same version.
