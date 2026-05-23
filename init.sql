-- Fuel Stations Table (ෂෙඩ් වල මූලික විස්තර)
CREATE TABLE fuel_stations (
    id SERIAL PRIMARY KEY,
    station_name VARCHAR(150) NOT NULL,
    company VARCHAR(50) NOT NULL,          -- Ceypetco, LIOC, Sinopec
    area VARCHAR(100) NOT NULL,             -- eg: Malabe, Maharagama
    latitude NUMERIC(10, 8) NOT NULL,
    longitude NUMERIC(11, 8) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Fuel Status Table (දැනට පවතින සජීවී තත්ත්වය)
CREATE TABLE fuel_status (
    id SERIAL PRIMARY KEY,
    station_id INT REFERENCES fuel_stations(id) ON DELETE CASCADE,
    fuel_type VARCHAR(20) NOT NULL,        -- 92, 95, AutoDiesel, SuperDiesel
    stock_status VARCHAR(20) DEFAULT 'Available', -- Available, OutOfStock
    queue_status VARCHAR(20) DEFAULT 'No Queue',   -- No Queue, Short, Long
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- User Reports Table (මිනිස්සු දාන updates වල ඉතිහාසය/Logs)
CREATE TABLE user_reports (
    id SERIAL PRIMARY KEY,
    station_id INT REFERENCES fuel_stations(id) ON DELETE CASCADE,
    fuel_type VARCHAR(20) NOT NULL,
    reported_stock VARCHAR(20) NOT NULL,
    reported_queue VARCHAR(20) NOT NULL,
    reported_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Testing Dummy Data (ලෝකල් එකේ ටෙස්ට් කරලා බලන්න ෂෙඩ් 2ක දත්ත)
INSERT INTO fuel_stations (station_name, company, area, latitude, longitude) VALUES
('Ceypetco Malabe', 'Ceypetco', 'Malabe', 6.90420000, 79.95480000),
('LIOC Maharagama', 'LIOC', 'Maharagama', 6.84810000, 79.92640000);

INSERT INTO fuel_status (station_id, fuel_type, stock_status, queue_status) VALUES
(1, '92', 'Available', 'Short Queue'),
(1, '95', 'OutOfStock', 'No Queue'),
(1, 'AutoDiesel', 'Available', 'Long Queue'),
(2, '92', 'Available', 'No Queue'),
(2, 'SuperDiesel', 'Available', 'Short Queue');
