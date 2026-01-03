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

[View on Eraser![](https://app.eraser.io/workspace/FxWGrvofJtLApVoJe31g/preview?elements=23SsGLBWPIkn0_YwUmPkmQ&type=embed)](https://app.eraser.io/workspace/FxWGrvofJtLApVoJe31g?elements=23SsGLBWPIkn0_YwUmPkmQ)