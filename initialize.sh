echo "initialize symmetricds configuration tables on host h2 db..."
bin/symadmin --engine corp-000 create-sym-tables
echo "initialize trigger flag on symmetricds tables..."
bin/dbimport --engine corp-000 versions/001/corp/initialize_link.sql
echo "initialize receiver table on target db..."
bin/dbimport --engine store-001 versions/002/store/initialize-store.sql
echo "initialization finished."
echo "run bin/sym to run symmetricds."
echo "or run bin/sym_service start to run symmetricds on daemon."
