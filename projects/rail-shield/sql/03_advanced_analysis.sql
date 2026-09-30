-- RAIL-SHIELD advanced analytical query pack
USE rail_shield;

-- 1. Delay by journey
SELECT journey_id,
       TIMESTAMPDIFF(MINUTE, planned_arrival, actual_arrival) AS arrival_delay_minutes
FROM journeys
ORDER BY arrival_delay_minutes DESC;

-- 2. Rank stations by average arrival delay
WITH station_delay AS (
    SELECT s.station_id, s.station_name,
           AVG(TIMESTAMPDIFF(MINUTE, js.planned_arrival, js.actual_arrival)) AS avg_delay
    FROM journey_segments js
    JOIN stations s ON s.station_id = js.destination_station_id
    GROUP BY s.station_id, s.station_name
)
SELECT *,
       DENSE_RANK() OVER (ORDER BY avg_delay DESC) AS delay_rank
FROM station_delay;

-- 3. Recurring disruption types
SELECT disruption_type,
       COUNT(*) AS events,
       SUM(delay_minutes) AS total_delay_minutes,
       ROUND(AVG(delay_minutes),2) AS avg_delay_minutes
FROM disruptions
GROUP BY disruption_type
ORDER BY total_delay_minutes DESC;

-- 4. Connection pressure
SELECT ce.connection_event_id,
       ce.journey_id,
       ce.planned_transfer_minutes,
       ce.actual_transfer_minutes,
       ce.actual_transfer_minutes - ce.planned_transfer_minutes AS transfer_overrun,
       CASE
           WHEN ce.actual_transfer_minutes > ce.planned_transfer_minutes
           THEN 'PRESSURED'
           ELSE 'WITHIN_WINDOW'
       END AS connection_signal
FROM connection_events ce;

-- 5. Passenger-level journey reliability
SELECT p.passenger_id,
       p.passenger_type,
       COUNT(j.journey_id) AS journeys,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE,j.planned_arrival,j.actual_arrival)),2) AS avg_delay
FROM passengers p
LEFT JOIN journeys j ON j.passenger_id = p.passenger_id
GROUP BY p.passenger_id, p.passenger_type;

-- 6. Segment contribution to total disruption delay
SELECT js.segment_id,
       s1.station_name AS origin,
       s2.station_name AS destination,
       COALESCE(SUM(d.delay_minutes),0) AS disruption_delay
FROM journey_segments js
JOIN stations s1 ON s1.station_id = js.origin_station_id
JOIN stations s2 ON s2.station_id = js.destination_station_id
LEFT JOIN disruptions d ON d.segment_id = js.segment_id
GROUP BY js.segment_id, s1.station_name, s2.station_name
ORDER BY disruption_delay DESC;

-- 7. Journey friction score (portfolio metric; weights are illustrative)
WITH metrics AS (
    SELECT j.journey_id,
           GREATEST(TIMESTAMPDIFF(MINUTE,j.planned_arrival,j.actual_arrival),0) AS delay_min,
           COALESCE(SUM(d.delay_minutes),0) AS disruption_min
    FROM journeys j
    LEFT JOIN journey_segments js ON js.journey_id=j.journey_id
    LEFT JOIN disruptions d ON d.segment_id=js.segment_id
    GROUP BY j.journey_id,j.planned_arrival,j.actual_arrival
)
SELECT journey_id,
       delay_min,
       disruption_min,
       ROUND(delay_min * 0.6 + disruption_min * 0.4,2) AS friction_score
FROM metrics
ORDER BY friction_score DESC;
