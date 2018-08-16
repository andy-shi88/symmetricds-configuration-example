### Symmetricds test configuration

#### Getting Started
- get to the project where your h2 file reside and run them in server mode by `java -cp "lib/h2*:lib/*" org.h2.tools.Console -tcpAllowOthers`
- open `engines/store-001.properties` and set `db.user`, `db.password` and `db.url` to your local setting [here we are using `postgres`]
- run `bin/symadmin --engine corp-000 create-sym-tables` to initialize the configuration tables.
- run `bin/dbimport --engine corp-000 versions/001/corp/initialize_link.sql` to initialize the basic configuration to our `corp-000` so it links to `store-001.properties`.
- run `bin/dbimport --engine store-001 versions/001/store/create_asset_and_trade.sql` initialize target table.
- run `bin/sym_service start` to run as service and `bin/sym_service stop` to stop the service.

### Add new trigger 
- create query at `versions/new_version/corp/sql_name.sql`
    ```
        insert into sym_channel 
        (channel_id, processing_order, max_batch_size, enabled, description)
        values('source_table_name', 1, 100000, 1, 'blockchain source_table_name table');

        insert into sym_trigger 
        (trigger_id,source_table_name,channel_id,last_update_time,create_time)
        values('source_table_name','source_table_name','source_table_name',current_timestamp,current_timestamp);

        insert into sym_trigger_router 
        (trigger_id,router_id,initial_load_order,last_update_time,create_time)
        values('source_table_name','corp_2_store', 100, current_timestamp, current_timestamp);
        ```
- import the query to `corp-000`. `bin/dbimport --engine corp-000 versions/new_version/corp/sql_name.sql`
- create table @store for new trigger.

### Create table @store for new trigger
- export the table query `bin/dbexport --engine corp-000 --compatible=postgres --no-data table_1 table_2 > versions/new_version/store`
- 

### Note
- if you get `org.h2.jdbc.JdbcSQLException: Connection is broken: "unexpected status 16777216" [90067-176]`, most likely it's caused by different version of `h2 jar` between your java project and the symmetricds, just copy the jar so they are the same version.
