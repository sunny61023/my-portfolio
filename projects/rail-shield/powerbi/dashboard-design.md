# Dashboard Design Specification

## Page 1 — Executive Reliability

Purpose: answer "How reliable are passenger journeys overall?"

Recommended visuals:
- Total Journeys
- On-Time Journey Rate
- Average Arrival Delay
- Total Disruption Minutes
- Connection Pressure Rate
- Journey trend by date
- Delay-band distribution

## Page 2 — Station & Segment Reliability

Purpose: locate where journey friction accumulates.

Recommended visuals:
- Station ranking by average arrival delay
- Origin → destination segment matrix
- Disruption minutes by segment
- Station-level journey volume
- Delay trend by station

## Page 3 — Connection Risk

Purpose: reveal transfer windows under operational pressure.

Recommended visuals:
- Planned vs actual transfer minutes
- Pressured connection count
- Connection pressure rate
- Journey-level transfer table
- Transfer overrun distribution

## Page 4 — Disruption Intelligence

Purpose: identify recurring operational patterns.

Recommended visuals:
- Disruption type frequency
- Total delay minutes by disruption type
- Severity distribution
- Disruption trend over time
- Segment contribution to disruption delay

## Page 5 — Journey Explorer

Purpose: allow drill-through from aggregate KPIs to a single passenger journey.

Recommended fields:
- Journey ID
- Journey date
- Passenger type
- Segment sequence
- Origin/destination
- Planned/actual timestamps
- Delay minutes
- Disruption type
- Connection status

## Design Principle

Every page should answer a business question. Avoid adding visuals solely for decoration.
