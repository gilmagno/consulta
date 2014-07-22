script/consulta_create.pl model DB DBIC::Schema Consulta::Schema \
                       create=static components=TimeStamp \
                       Schema::Loader generate_pod=0 \
                       'dbi:Pg:dbname=consulta' 'postgres' 'postgres'
