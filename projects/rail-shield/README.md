# RAIL-SHIELD — Passenger Journey Reliability Analytics

## Portfolio Project

**RAIL-SHIELD** is an original data-analytics portfolio project that treats a passenger trip as a connected journey instead of a collection of isolated delay records.

It investigates how delays, disruptions, station segments and transfer windows combine to create passenger journey friction.

> **Positioning:** This is a portfolio analytics concept using synthetic/sample data. It is not an official railway system and is not affiliated with Indian Railways.

## Business Problem

Traditional delay reporting can answer: **"How many minutes was a train delayed?"**

RAIL-SHIELD asks a broader analytical question:

**"Where does a passenger journey repeatedly lose time, and which connected events contribute to that friction?"**

## Questions Answered

- Which journeys accumulate the highest delay?
- Which stations and segments show recurring delay?
- Which disruption types contribute the most lost time?
- Which connections become operationally pressured?
- Where does friction accumulate inside multi-segment journeys?
- Which patterns deserve operational investigation?

## Analytical Framework

```text
Journey Data → Validation → Relational Model → SQL Analysis
           → Python EDA → Reliability KPIs → Power BI
           → Operational Investigation Signals
```

## Data Model

- Stations
- Passengers
- Journeys
- Journey segments
- Disruptions
- Connection events

This supports analysis at passenger, journey, segment, station, disruption and connection levels.

## Core Analytics

**Reliability**
- Total journeys
- Completed journeys
- On-time journey rate
- Average arrival delay

**Disruption**
- Total disruption minutes
- Disruption frequency
- Delay contribution by disruption type
- Segment-level disruption contribution

**Connection**
- Planned transfer time
- Actual transfer time
- Transfer overrun
- Connection pressure rate

**Portfolio Metric**
- Journey Friction Score — a documented portfolio-defined composite signal using delay and disruption exposure.

## Technology Stack

| Layer | Technology |
|---|---|
| Database | MySQL |
| SQL | Joins, CTEs, window functions, CASE, aggregation |
| Analysis | Python, Pandas, NumPy |
| EDA | Missingness, distributions, delay bands, operational signals |
| Visualization | Power BI |
| Version Control | Git / GitHub |
| Development | VS Code / MySQL Workbench |

## Repository Structure

```text
projects/rail-shield/
├── README.md
├── data/
│   └── README.md
├── sql/
│   ├── 01_schema.sql
│   ├── 02_sample_data.sql
│   └── 03_advanced_analysis.sql
├── python/
│   ├── 01_eda.py
│   └── README.md
├── powerbi/
│   ├── dax-measures.md
│   ├── dashboard-design.md
│   └── README.md
└── docs/
    ├── analytical-framework.md
    ├── business-questions.md
    └── limitations.md
```

## Power BI Dashboard

1. **Executive Reliability** — journey volume, on-time rate, delay and disruption KPIs.
2. **Station & Segment Reliability** — where delay and disruption accumulate.
3. **Connection Risk** — planned versus actual transfer pressure.
4. **Disruption Intelligence** — recurring disruption patterns.
5. **Journey Explorer** — drill from aggregate KPIs to journey and segment detail.

## Data & Responsible Use

The current records are synthetic/sample records created for portfolio demonstration.

This repository does not claim official railway performance, official railway definitions, deployment by a railway organization, or causality from correlation alone.

A production implementation would require source provenance, privacy controls, validation, domain review and refresh governance.

## What This Project Demonstrates

- Translating an operational problem into analytical questions
- Relational data modeling
- Advanced SQL
- Python feature engineering and EDA
- KPI design
- Power BI dashboard architecture
- Responsible documentation
- Git/GitHub-based reproducibility

## Future Extensions

- Larger time-series datasets
- Route reliability benchmarking
- Statistical anomaly detection
- Automated data-quality tests
- Scheduled dashboard refresh
- Real-time ingestion architecture

## Author

**Sunny — Data Analytics Portfolio**

Target roles: Data Analyst · Junior Data Analyst · BI / Reporting Analyst · Business Analytics Intern · Operations Analyst
