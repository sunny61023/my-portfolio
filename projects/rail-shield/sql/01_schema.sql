-- RAIL-SHIELD: Passenger Journey Reliability Analytics
-- MySQL schema foundation
-- Portfolio project: analytical, not an official railway system.

CREATE DATABASE IF NOT EXISTS rail_shield;
USE rail_shield;

CREATE TABLE stations (
    station_id INT PRIMARY KEY,
    station_code VARCHAR(10) NOT NULL UNIQUE,
    station_name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100)
);

CREATE TABLE passengers (
    passenger_id BIGINT PRIMARY KEY,
    age_group VARCHAR(30),
    passenger_type VARCHAR(50),
    origin_state VARCHAR(100)
);

CREATE TABLE journeys (
    journey_id BIGINT PRIMARY KEY,
    passenger_id BIGINT NOT NULL,
    journey_date DATE NOT NULL,
    planned_departure DATETIME,
    actual_departure DATETIME,
    planned_arrival DATETIME,
    actual_arrival DATETIME,
    journey_status VARCHAR(30),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id)
);

CREATE TABLE journey_segments (
    segment_id BIGINT PRIMARY KEY,
    journey_id BIGINT NOT NULL,
    sequence_no INT NOT NULL,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    planned_departure DATETIME,
    actual_departure DATETIME,
    planned_arrival DATETIME,
    actual_arrival DATETIME,
    transfer_window_minutes INT,
    FOREIGN KEY (journey_id) REFERENCES journeys(journey_id),
    FOREIGN KEY (origin_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES stations(station_id)
);

CREATE TABLE disruptions (
    disruption_id BIGINT PRIMARY KEY,
    segment_id BIGINT NOT NULL,
    disruption_type VARCHAR(80) NOT NULL,
    severity VARCHAR(30),
    start_time DATETIME,
    end_time DATETIME,
    delay_minutes INT DEFAULT 0,
    FOREIGN KEY (segment_id) REFERENCES journey_segments(segment_id)
);

CREATE TABLE connection_events (
    connection_event_id BIGINT PRIMARY KEY,
    journey_id BIGINT NOT NULL,
    incoming_segment_id BIGINT NOT NULL,
    outgoing_segment_id BIGINT NOT NULL,
    planned_transfer_minutes INT,
    actual_transfer_minutes INT,
    connection_status VARCHAR(30),
    FOREIGN KEY (journey_id) REFERENCES journeys(journey_id),
    FOREIGN KEY (incoming_segment_id) REFERENCES journey_segments(segment_id),
    FOREIGN KEY (outgoing_segment_id) REFERENCES journey_segments(segment_id)
);

-- Example analytical KPI: average arrival delay by destination station.
SELECT
    s.station_name,
    COUNT(*) AS journey_count,
    ROUND(AVG(
        TIMESTAMPDIFF(
            MINUTE,
            j.planned_arrival,
            j.actual_arrival
        )
    ), 2) AS avg_arrival_delay_minutes
FROM journeys j
JOIN journey_segments js
    ON j.journey_id = js.journey_id
JOIN stations s
    ON js.destination_station_id = s.station_id
GROUP BY s.station_id, s.station_name
ORDER BY avg_arrival_delay_minutes DESC;
