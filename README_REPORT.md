Relatório de Entrega — Atendas BI (Desafio Técnico)

Resumo executivo
Este repositório contém a entrega completa do desafio Atendas BI solicitada pelo processo seletivo. O pacote inclui consultas SQL com as respostas analíticas, um pacote de importação do Apache Superset com datasets, gráficos e dashboard prontos, e uma apresentação executiva em PDF com os principais insights.

Entregáveis
- respostas.sql — consultas SQL que respondem aos requisitos do desafio.
- export_final_for_delivery.zip — pacote de importação do Superset (datasets, charts, dashboards).
- apresentacao_executiva.pdf — apresentação executiva com gráficos e recomendações.
- export_final_extracted/ (opcional) — extração do ZIP para inspeção dos YAMLs gerados.

Como reproduzir (resumo rápido)
1. Iniciar serviços Docker (Postgres + Superset):
   docker compose up -d
2. Se necessário, importar o dump inicial para o Postgres: db_init/01_init.sql
3. No Superset, importar o pacote:
   superset import-dashboards -p /caminho/para/export_final_for_delivery.zip
   ou usar a UI: Menu -> Manage -> Import dashboards
4. Validar dados: as views e tabelas usadas para os datasets foram criadas no banco durante a execução. Verifique a conexão de banco de dados nomeada "atendas_bi" no Superset.

Notas técnicas e observações
- Backup do metastore: foi feito backup do arquivo superset.db antes de alterações diretas no metastore. Arquivo original preservado no ambiente usado para geração.
- Abordagem usada: para garantir confiabilidade, os datasets foram criados via API interna do Superset (import_from_dict) e o pacote final gerado com o CLI superset export-dashboards.
- CSRF / RISON: a automação via REST pública apresentou limitações (CSRF / RISON encoding). Por isso a criação foi feita diretamente no metastore com backup prévio.
- Arquivos grandes: o dump SQL (db_init/01_init.sql) possui dados volumosos; a importação pode demorar dependendo do host.

Verificação realizada
- Execução do fluxo completo em ambiente Docker: População do banco, criação das views, criação de datasets, slices e dashboard, exportação do pacote e geração da apresentação.
- Release criada no GitHub: v1.0 com export_final_for_delivery.zip e apresentacao_executiva.pdf (ver: https://github.com/luisfernandoti2021-cell/atendas-bi-analista-dados-pleno/releases/tag/v1.0).

Próximos passos recomendados
- Caso deseje maior automação end-to-end sem tocar metastore, podemos preparar um script que utilize a API do Superset com gerenciamento de CSRF e RISON ou migrar para uma instância com API token dedicado.
- Revisar políticas de versionamento de dados e excluir arquivos binários grandes do histórico (usar release para distribuir bins).

Contato
Para dúvidas técnicas ou ajustes adicionais, posso gerar um roteiro passo-a-passo ou executar modificações específicas mediante autorização.

---
Documento gerado automaticamente pela entrega; para histórico e auditoria ver commits no branch main.
## Insights Principais

1. Uso de Canais
- O WhatsApp concentra a maior parte do volume de mensagens e é o principal driver de receita. Recomenda-se priorizar monitoramento e otimização de custo/preço para este canal.

2. Concentração de Receita
- Uma pequena porcentagem de clientes gera a maior parcela da receita (top N). Recomenda-se identificar estes clientes e garantir SLAs e planos de retenção dedicados.

3. Correlação Tráfego x Suporte
- Aumentos de volume de mensagens tendem a preceder picos de tickets de suporte. Implementar alertas de anomalia para tráfego que indiquem necessidade de scaling ou atenção do suporte.

4. SLA e CSAT
- Alguns segmentos/categorias apresentam tempo médio de resolução acima da média e CSAT abaixo do esperado. Priorizar investigação em categorias com alta porcentagem de detratores.

## Recomendações de Ação

- Implementar alertas operacionais: monitorar taxa de entrega, taxa de falhas e SLA médio por cliente e por canal.
- Criar runbook de retenção: mapear clientes com queda de uso nos 3 meses anteriores e acionar Customer Success proativamente.
- Implementar materialized views e agendador (cron) para precalcular métricas mensais e aliviar consultas no dashboard.
- Adotar testes automatizados de métricas (SQL/unit tests) para garantir qualidade das métricas em PRs.
- Versionar e publicar um pacote de métricas (camada semântica) para uso nos dashboards e relatórios.

## Perguntas-chave para a Entrevista

- Por que analisar os 3 meses antes do churn?
  Porque as variações imediatas anteriores ao cancelamento são os sinais mais úteis para ação preventiva (queda de uso, aumento de falhas ou piora de CSAT).

- Qual KPI é mais importante?
  Receita isolada não basta; priorize conjunto: Receita, Churn, SLA e CSAT para avaliar saúde do cliente.

## Próximos Passos

1. Validar dashboards em instância limpa do Superset (import do ZIP). 
2. Implementar monitoramento e alertas (Prometheus/Datadog ou processos internos). 
3. Preparar pipeline ETL/ELT para camada analítica e automatizar refresh das materialized views.

