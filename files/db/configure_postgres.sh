echo "standard_conforming_strings = off" >> /var/lib/pgsql/data/postgresql.conf 
echo "host all all 0.0.0.0/0 trust" >> /var/lib/pgsql/data/pg_hba.conf
service postgresql restart
