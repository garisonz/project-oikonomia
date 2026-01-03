# Oikonomia: Automated Economic Data Warehouse

![Build Status](https://img.shields.io/badge/build-passing-success)
![Docker](https://img.shields.io/badge/container-docker-blue)
![Airflow](https://img.shields.io/badge/orchestrator-airflow-red)
![Postgres](https://img.shields.io/badge/warehouse-postgres-336791)
![Python](https://img.shields.io/badge/language-python-yellow)

> *"Oikonomia" (Ancient Greek: οἰκονομία) – The management of a household. The etymological root of "Economy."*

## 📖 Overview
**Oikonomia** is a production-grade **ELT (Extract, Load, Transform)** pipeline designed to "manage the household" of US economic data. 

Instead of relying on fragile, one-off scripts, this platform treats economic data ingestion as a critical engineering problem. It orchestrates the daily ingestion of key indicators (GDP, Unemployment, Inflation) from the Federal Reserve (FRED) API, stores them in a raw staging layer, and transforms them into a reliable **Star Schema** for historical analysis.

### 🎯 Key Engineering Features
* **Self-Healing Pipelines:** Uses **Apache Airflow** to handle retries, failures, and scheduling automatically.
* **Idempotency:** Ingestion logic is designed to be run multiple times without creating duplicate records (Upsert logic).
* **Schema-on-Read:** Utilizes PostgreSQL `JSONB` for the raw layer, preventing pipeline failures even if the upstream API schema changes.
* **Infrastructure as Code:** The entire environment (Database, Scheduler, Webserver) is defined and spun up via Docker Compose.

---

## 🏗 Architecture

The system follows a modern **Microservices** architecture. Each component is containerized and decoupled.

```mermaid
graph TD
    %% Define Nodes
    subgraph External ["☁️ External Data"]
        FredAPI[("FRED API")]
    end

    subgraph Docker ["🐳 Oikonomia Container Host"]
        
        subgraph Orchestrator ["🧠 Orchestration"]
            Scheduler["Airflow Scheduler<br/>(Daily Cron)"]
        end

        subgraph ELT ["⚙️ Processing"]
            Ingest["Python Ingest<br/>(Extract & Load)"]
            dbt["dbt Core<br/>(Transform & Test)"]
        end

        subgraph Warehouse ["💾 Storage (PostgreSQL)"]
            Raw[("Schema: raw<br/>(JSONB Staging)")]
            Clean[("Schema: serving<br/>(Star Schema)")]
        end

        subgraph App ["📊 Presentation"]
            Streamlit["Streamlit Dashboard"]
        end
    end

    %% Data Flow
    FredAPI -->|JSON| Ingest
    Scheduler -->|Trigger| Ingest
    Ingest -->|Write| Raw
    
    Scheduler -->|Trigger| dbt
    dbt -->|Read| Raw
    dbt -->|Materialize| Clean
    
    Streamlit -->|SQL Query| Clean