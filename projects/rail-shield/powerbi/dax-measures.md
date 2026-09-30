# RAIL-SHIELD — Power BI DAX Measures

These measures are a dashboard specification. Column/table names should be aligned with the final Power BI model after importing the analysis-ready dataset.

## Journey Volume

```DAX
Total Journeys =
DISTINCTCOUNT(journeys[journey_id])
```

## Completed Journeys

```DAX
Completed Journeys =
CALCULATE(
    [Total Journeys],
    journeys[journey_status] = "COMPLETED"
)
```

## Average Arrival Delay

```DAX
Average Arrival Delay (Min) =
AVERAGEX(
    journeys,
    MAX(
        0,
        DATEDIFF(
            journeys[planned_arrival],
            journeys[actual_arrival],
            MINUTE
        )
    )
)
```

## On-Time Journey Rate

Portfolio definition: arrival delay of 5 minutes or less.

```DAX
On-Time Journey Rate % =
VAR OnTimeJourneys =
    COUNTROWS(
        FILTER(
            journeys,
            DATEDIFF(
                journeys[planned_arrival],
                journeys[actual_arrival],
                MINUTE
            ) <= 5
        )
    )
RETURN
DIVIDE(OnTimeJourneys, [Total Journeys], 0)
```

## Total Disruption Minutes

```DAX
Total Disruption Minutes =
SUM(disruptions[delay_minutes])
```

## Pressured Connections

```DAX
Pressured Connections =
COUNTROWS(
    FILTER(
        connection_events,
        connection_events[actual_transfer_minutes] >
        connection_events[planned_transfer_minutes]
    )
)
```

## Connection Pressure Rate

```DAX
Connection Pressure Rate % =
DIVIDE(
    [Pressured Connections],
    COUNTROWS(connection_events),
    0
)
```

## Notes

These are portfolio-defined measures, not official railway performance definitions. Thresholds and metric weights must be documented when changed.
