#!/usr/bin/env bash
# Bash setup script
# 1. Start docker-compose
docker compose up -d
# 2. Import dump (optional)
# psql -h localhost -p 5432 -U postgres -d atendas_bi -f db_init/01_init.sql
# 3. Create example view
# psql -h localhost -p 5432 -U postgres -d atendas_bi -c "CREATE OR REPLACE VIEW view_finance_monthly AS SELECT 1 as dummy;"
# 4. Export superset (run inside superset container)
# docker compose exec superset superset export-dashboards -f /tmp/export_final_for_delivery.zip
