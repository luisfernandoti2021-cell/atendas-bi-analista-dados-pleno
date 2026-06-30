# 📊 Atendas BI – Desafio Técnico
### Analista de Dados Pleno

![License](https://img.shields.io/badge/license-MIT-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue)
![Apache Superset](https://img.shields.io/badge/Apache-Superset-orange)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED)

Projeto desenvolvido como solução para o **Desafio Técnico de Analista de Dados Pleno** da **Atendas CPaaS**, contemplando consultas SQL analíticas, construção de indicadores de negócio e dashboards executivos utilizando Apache Superset.

---

# 📑 Sumário

- Objetivo de Negócio
- Arquitetura da Solução
- Tecnologias Utilizadas
- KPIs Entregues
- Principais Insights
- Estrutura do Projeto
- Como Executar
- Entregáveis
- Melhorias Futuras
- Autor

---

# 🎯 Objetivo de Negócio

O objetivo deste projeto é analisar o comportamento de utilização da plataforma CPaaS da Atendas, identificando padrões de consumo, desempenho dos canais de comunicação e eficiência operacional do suporte ao cliente.

A solução foi construída para apoiar a tomada de decisão através de indicadores estratégicos, consultas SQL e dashboards executivos.

---

# 🏗 Arquitetura da Solução

```text
                PostgreSQL
                     │
                     ▼
          Views Analíticas (SQL)
                     │
                     ▼
             Apache Superset
                     │
                     ▼
          Dashboards Executivos
                     │
                     ▼
          Insights para o Negócio
```

---

# 🛠 Tecnologias Utilizadas

- PostgreSQL
- SQL
- Apache Superset
- Docker
- Docker Compose
- Git
- GitHub

---

# 📈 KPIs Entregues

| Indicador | Objetivo |
|------------|----------|
| Total de Mensagens | Volume total trafegado |
| Receita Bruta | Volume financeiro gerado |
| Margem Operacional | Receita x Custos |
| Taxa de Entrega | Eficiência das comunicações |
| Empresas Ativas | Utilização da plataforma |
| SLA Médio | Tempo médio de resolução |
| CSAT Médio | Satisfação dos clientes |
| Churn | Receita média antes do cancelamento |

---

# 💡 Principais Insights

- O canal **WhatsApp** concentra a maior parte do volume de mensagens da plataforma.
- Um pequeno grupo de clientes representa grande parte do consumo da solução.
- Existe correlação entre aumento do volume de mensagens e crescimento dos tickets de suporte.
- Algumas categorias apresentam SLA superior à média e podem ser priorizadas para melhoria.
- A análise dos três meses anteriores ao churn permite identificar possíveis comportamentos de risco e apoiar ações preventivas.

---

# 📁 Estrutura do Projeto

```
.
├── db_init/
│   └── 01_init.sql
│
├── sql/
│   └── respostas.sql
│
├── scripts/
│   ├── setup.sh
│   └── setup.ps1
│
├── export_final_for_delivery.zip
├── apresentacao_executiva.pdf
├── README_REPORT.md
└── README.md
```

---

# 🚀 Como Executar

## 1. Clonar o projeto

```bash
git clone https://github.com/luisfernandoti2021-cell/atendas-bi-analista-dados-pleno.git

cd atendas-bi-analista-dados-pleno
```

## 2. Subir os containers

```bash
docker compose up -d
```

## 3. Acessar o Apache Superset

```
URL: http://localhost:8088

Usuário: admin

Senha: admin
```

## 4. Importar Dashboard

Via interface:

```
Settings
→ Import Dashboards
→ export_final_for_delivery.zip
```

Ou via CLI:

```bash
superset import-dashboards -p export_final_for_delivery.zip
```

---

# 📦 Entregáveis

- ✅ respostas.sql
- ✅ Dashboard Apache Superset
- ✅ Dashboard Export (.zip)
- ✅ Apresentação Executiva (.pdf)
- ✅ README_REPORT.md

---

# 📊 Consultas Desenvolvidas

O projeto contempla análises relacionadas a:

- Volume e faturamento mensal
- Margem operacional
- Taxa de entrega
- Receita média antes do churn
- SLA por categoria
- CSAT por segmento
- Percentual de detratores

---

# 🔍 Melhorias Futuras

- Construção de camada dimensional (Data Warehouse)
- Implementação de monitoramento de SLA
- Alertas automáticos para degradação operacional
- Forecast de volume de mensagens
- Dashboard em tempo real
- Monitoramento de churn preditivo

---

# 👨‍💻 Autor

**Luis Fernando André Oliveira**

Analista de Sistemas • Arquiteto de Soluções • Analista de Dados

GitHub:
https://github.com/luisfernandoti2021-cell

LinkedIn:
(https://www.linkedin.com/in/fernando-oliveira-916883149/)
