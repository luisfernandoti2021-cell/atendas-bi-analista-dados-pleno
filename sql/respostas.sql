-- respostas.sql\n-- Consultas para o Desafio Atendas BI\n-- Autor: Luis Fernando\n-- Gerado: 2026-06-22T11:05:37.8943803-03:00\n\n-- respostas.sql
-- Consultas para o Desafio Atendas BI

-- 1) Volume e Faturamento Mensal (apenas Outbound) por mês e canal
WITH outbound AS (
  SELECT
    date_trunc('month', created_at) AS month,
    c.name AS channel,
    COUNT(*) AS volume,
    SUM(billing_price) AS faturamento_bruto,
    SUM(billing_cost) AS custo_total
  FROM messages_sent m
  JOIN channels c ON m.channel_id = c.id
  WHERE m.direction = 'Outbound'
  GROUP BY 1,2
)
SELECT
  month,
  channel,
  volume,
  faturamento_bruto,
  custo_total,
  (faturamento_bruto - custo_total) AS margem_valor,
  CASE WHEN faturamento_bruto = 0 THEN 0
       ELSE ROUND((faturamento_bruto - custo_total) / faturamento_bruto * 100, 2)
  END AS margem_percentual
FROM outbound
ORDER BY month, channel;

-- 2) Taxa de Sucesso de Entrega (Delivered / total) mensal por canal
WITH totals AS (
  SELECT
    date_trunc('month', created_at) AS month,
    c.name AS channel,
    COUNT(*) AS total_msgs,
    SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered
  FROM messages_sent m
  JOIN channels c ON m.channel_id = c.id
  WHERE m.direction = 'Outbound'
  GROUP BY 1,2
)
SELECT
  month,
  channel,
  total_msgs,
  delivered,
  CASE WHEN total_msgs = 0 THEN 0
       ELSE ROUND(delivered::numeric / total_msgs * 100, 2)
  END AS delivery_rate_percent
FROM totals
ORDER BY month, channel;

-- 3) Churn e receita média mensal nos 3 meses anteriores ao churn
WITH churn_companies AS (
  SELECT id, name, segment, churn_date
  FROM companies
  WHERE status = 'Churned'
), rev AS (
  SELECT
    cc.id AS company_id,
    cc.name AS company_name,
    cc.segment,
    cc.churn_date,
    date_trunc('month', m.created_at) AS month,
    SUM(m.billing_price) AS month_revenue
  FROM messages_sent m
  JOIN churn_companies cc ON m.company_id = cc.id
  WHERE m.direction = 'Outbound'
    AND m.created_at >= (cc.churn_date - INTERVAL '3 months')
    AND m.created_at < cc.churn_date
  GROUP BY 1,2,3,4,5
)
SELECT
  company_id,
  company_name,
  segment,
  churn_date,
  ROUND(COALESCE(SUM(month_revenue),0)::numeric / 3, 2) AS avg_rev_last_3_months,
  COUNT(month) AS months_with_data
FROM rev
GROUP BY company_id, company_name, segment, churn_date
ORDER BY avg_rev_last_3_months DESC;

-- 4) SLA: tempo médio de resolução de tickets (em horas) por categoria e por mês
SELECT
  date_trunc('month', created_at) AS month,
  category,
  ROUND(AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600)::numeric, 2) AS avg_resolution_hours,
  COUNT(*) FILTER (WHERE resolved_at IS NOT NULL) AS resolved_count
FROM support_tickets
WHERE resolved_at IS NOT NULL
GROUP BY 1,2
ORDER BY month, category;

-- 5) CSAT: nota média por segmento + percentual de detratores (1 ou 2) por categoria
-- 5a) CSAT médio por segmento
SELECT
  c.segment,
  ROUND(AVG(st.rating)::numeric, 2) AS avg_csat,
  COUNT(st.rating) AS ratings_count
FROM support_tickets st
JOIN companies c ON st.company_id = c.id
WHERE st.rating IS NOT NULL
GROUP BY c.segment
ORDER BY avg_csat DESC;

-- 5b) Percentual de detratores (rating 1 ou 2) por categoria
SELECT
  category,
  COUNT(*) FILTER (WHERE rating IN (1,2)) AS detractor_count,
  COUNT(*) FILTER (WHERE rating IS NOT NULL) AS total_ratings,
  CASE WHEN COUNT(*) FILTER (WHERE rating IS NOT NULL) = 0 THEN 0
       ELSE ROUND( (COUNT(*) FILTER (WHERE rating IN (1,2))::numeric / COUNT(*) FILTER (WHERE rating IS NOT NULL)) * 100, 2)
  END AS detractor_percent
FROM support_tickets
GROUP BY category
ORDER BY detractor_percent DESC;

