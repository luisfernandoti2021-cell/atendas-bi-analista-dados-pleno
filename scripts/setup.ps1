# PowerShell setup script
# 1. Inicia o docker-compose
docker compose up -d
# 2. Importa o dump (opcional)
# psql -h localhost -p 5432 -U postgres -d atendas_bi -f db_init/01_init.sql
# 3. Gera as views usadas pelo Superset (exemplo)
# psql -h localhost -p 5432 -U postgres -d atendas_bi -c "CREATE OR REPLACE VIEW view_finance_monthly AS SELECT 1 as dummy;"
# 4. Export do superset (rodar dentro do container superset)
# docker compose exec superset superset export-dashboards -f /tmp/export_final_for_delivery.zip
