# RAIL-SHIELD — Passenger Journey Reliability Analytics

> An original data-analytics portfolio project focused on understanding passenger journey reliability as a connected journey rather than treating delays as isolated events.

## Business Problem

Railway performance is often viewed through individual delay records. A passenger, however, experiences a journey made of stations, transfers, waiting windows, disruptions and connections.

RAIL-SHIELD models these connected events to answer:

- Where do journeys repeatedly lose time?
- Which station segments create the most transfer friction?
- Which journeys are exposed to missed connections?
- Which disruption patterns repeat across time?
- Where should operations teams investigate first?

## Analytical Approach

**Journey events → reliability metrics → friction signals → root-cause analysis → operational dashboard**

### Core KPIs

- On-time journey rate
- Average delay minutes
- Transfer-risk rate
- Missed-connection rate
- Average station dwell time
- Disruption recurrence rate
- Journey friction score

## Technology

- MySQL / SQL
- Python
- Pandas / NumPy
- Exploratory Data Analysis
- Power BI
- Git / GitHub

## Repository Structure

```text
projects/rail-shield/
├── README.md
├── sql/
│   └── 01_schema.sql
├── python/
│   └── README.md
├── powerbi/
│   └── README.md
├── data/
│   └── README.md
└── docs/
    └── analytical-framework.md
```

## Data Model

The initial relational model separates passengers, journeys, stations, journey segments, disruptions and connection events so reliability can be analysed at multiple levels.

## Portfolio Positioning

This project is intentionally designed around an uncommon analytical framing: **passenger journey reliability**, not simply train-delay reporting.

It is a portfolio concept and does not claim to represent official railway operational data.

## Author

Sunny — Data Analytics Portfolio
