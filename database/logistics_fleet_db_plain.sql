-- =====================================================================
-- PostgreSQL Dump - logistics_fleet_db
-- Converted from MySQL dump (8.0.45) generated on 2026-08-06
-- =====================================================================

-- Create the database (run this separately if needed, then connect to it)
-- CREATE DATABASE logistics_fleet_db;
-- \c logistics_fleet_db

BEGIN;

-- =====================================================================
-- Drop existing objects in reverse dependency order
-- =====================================================================
DROP TABLE IF EXISTS routes CASCADE;
DROP TABLE IF EXISTS maintenances CASCADE;
DROP TABLE IF EXISTS driver_licenses CASCADE;
DROP TABLE IF EXISTS drivers CASCADE;
DROP TABLE IF EXISTS vehicles CASCADE;
DROP TABLE IF EXISTS license_categories CASCADE;

DROP TYPE IF EXISTS driver_status CASCADE;
DROP TYPE IF EXISTS vehicle_status CASCADE;
DROP TYPE IF EXISTS fuel_type CASCADE;
DROP TYPE IF EXISTS route_status CASCADE;

-- =====================================================================
-- Custom ENUM types
-- =====================================================================
CREATE TYPE driver_status AS ENUM ('AVAILABLE', 'IN_ROUTE', 'OFF_DUTY', 'RESTING');
CREATE TYPE vehicle_status AS ENUM ('AVAILABLE', 'IN_ROUTE', 'MAINTENANCE', 'MAINTENANCE_REQUIRED');
CREATE TYPE fuel_type AS ENUM ('DIESEL', 'NORMAL', 'BIOFUEL');
CREATE TYPE route_status AS ENUM('IN_PROGRESS', 'COMPLETED', 'CANCELED');

-- =====================================================================
-- Table: license_categories
-- =====================================================================
CREATE TABLE license_categories (
    id_category SERIAL PRIMARY KEY,
    category_name VARCHAR(3) NOT NULL
);

INSERT INTO license_categories (id_category, category_name) VALUES
    (1, 'A1'),
    (2, 'A2'),
    (3, 'B1'),
    (4, 'B2'),
    (5, 'B3'),
    (6, 'C1'),
    (7, 'C2'),
    (8, 'C3');

SELECT setval('license_categories_id_category_seq', (SELECT MAX(id_category) FROM license_categories));

-- =====================================================================
-- Table: drivers
-- =====================================================================
CREATE TABLE drivers (
    id_driver SERIAL PRIMARY KEY,
    num_identification INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    second_lastname VARCHAR(50) DEFAULT NULL,
    contratation_date DATE DEFAULT NULL,
    status driver_status DEFAULT 'AVAILABLE',
    CONSTRAINT num_identification_positive CHECK(num_identification > 0),
    CONSTRAINT contratation_date_driver_d CHECK(contratation_date <= CURRENT_DATE)
);

INSERT INTO drivers (id_driver, num_identification, name, lastname, second_lastname, contratation_date, status) VALUES
    (1, 10123456, 'Andrés', 'García', 'López', '2022-01-10', 'AVAILABLE'),
    (2, 10234567, 'Beatriz', 'Mendoza', 'Pérez', '2022-03-15', 'AVAILABLE'),
    (3, 10345678, 'Camilo', 'Torres', 'Rojas', '2022-06-20', 'AVAILABLE'),
    (4, 10456789, 'Diana', 'Ramírez', 'Cano', '2022-08-05', 'AVAILABLE'),
    (5, 10567890, 'Esteban', 'Quintero', 'Mejía', '2022-11-12', 'AVAILABLE'),
    (6, 20123456, 'Fabián', 'Castro', 'Hernández', '2023-01-30', 'AVAILABLE'),
    (7, 20234567, 'Gloria', 'Sánchez', 'Vargas', '2023-02-14', 'AVAILABLE'),
    (8, 20345678, 'Hugo', 'Martínez', 'Osorio', '2023-04-10', 'AVAILABLE'),
    (9, 20456789, 'Isabel', 'Jiménez', 'Pineda', '2023-05-22', 'AVAILABLE'),
    (10, 20567890, 'Jorge', 'Gómez', 'Suárez', '2023-07-01', 'AVAILABLE'),
    (11, 30123456, 'Karen', 'Álvarez', 'Ruiz', '2023-08-15', 'AVAILABLE'),
    (12, 30234567, 'Luis', 'Moreno', 'Díaz', '2023-10-05', 'AVAILABLE'),
    (13, 30345678, 'Mónica', 'Ortiz', 'Morales', '2023-12-10', 'AVAILABLE'),
    (14, 30456789, 'Nelson', 'Herrera', 'Giraldo', '2024-01-20', 'AVAILABLE'),
    (15, 30567890, 'Paola', 'Valencia', 'Ríos', '2024-02-25', 'AVAILABLE');

SELECT setval('drivers_id_driver_seq', (SELECT MAX(id_driver) FROM drivers));

-- =====================================================================
-- Table: vehicles
-- =====================================================================
CREATE TABLE vehicles (
    id_vehicle SERIAL PRIMARY KEY,
    number_plate VARCHAR(7) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model SMALLINT NOT NULL,
    load_capacity INTEGER DEFAULT NULL,
    mileage INTEGER NOT NULL,
    axles INTEGER DEFAULT NULL,
    fuel_type fuel_type DEFAULT 'DIESEL',
    status vehicle_status DEFAULT 'AVAILABLE',
    CONSTRAINT load_capacity_positive_chk CHECK(load_capacity > 0),
    CONSTRAINT mileage_positive_chk CHECK(mileage >= 0)
);

INSERT INTO vehicles (id_vehicle, number_plate, brand, model, load_capacity, mileage, axles, fuel_type, status) VALUES
    (1, 'KGT101', 'Kenworth', 2022, 5000, 12500, 2, 'DIESEL', 'AVAILABLE'),
    (2, 'LMX202', 'Chevrolet', 2018, 12000, 45000, 6, 'DIESEL', 'AVAILABLE'),
    (3, 'NBH303', 'Foton', 2021, 2500, 8900, 2, 'NORMAL', 'AVAILABLE'),
    (4, 'OJP404', 'Hino', 2020, 8000, 22300, 3, 'DIESEL', 'AVAILABLE'),
    (5, 'PWQ505', 'International', 2015, 15000, 67800, 6, 'DIESEL', 'AVAILABLE'),
    (6, 'RTY606', 'Jac', 2023, 4500, 15600, 2, 'DIESEL', 'AVAILABLE'),
    (7, 'SDF707', 'Kenworth', 2019, 10000, 34200, 3, 'DIESEL', 'AVAILABLE'),
    (8, 'XCV808', 'Chevrolet', 2017, 3500, 9100, 2, 'NORMAL', 'AVAILABLE'),
    (9, 'VBN909', 'Mercedes-Benz', 2024, 18000, 89000, 6, 'DIESEL', 'AVAILABLE'),
    (10, 'QWE111', 'Foton', 2021, 6000, 18700, 2, 'DIESEL', 'AVAILABLE'),
    (11, 'ASD222', 'Hino', 2016, 12000, 52100, 6, 'DIESEL', 'AVAILABLE'),
    (12, 'ZXC333', 'Chevrolet', 2023, 2000, 4500, 2, 'NORMAL', 'AVAILABLE'),
    (13, 'YUI444', 'International', 2018, 7500, 29800, 3, 'DIESEL', 'AVAILABLE'),
    (14, 'HJK555', 'Kenworth', 2020, 14000, 71200, 6, 'DIESEL', 'AVAILABLE'),
    (15, 'BNM666', 'Jac', 2022, 5500, 13400, 2, 'DIESEL', 'AVAILABLE');

SELECT setval('vehicles_id_vehicle_seq', (SELECT MAX(id_vehicle) FROM vehicles));

-- =====================================================================
-- Table: driver_licenses
-- [FIX #7] Se agregaron licencias C3 (ids 24-38) para los 15 conductores
-- =====================================================================
CREATE TABLE driver_licenses (
    id_license SERIAL PRIMARY KEY,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    description VARCHAR(100) DEFAULT NULL,
    id_category INTEGER NOT NULL,
    id_driver INTEGER NOT NULL,
    CONSTRAINT expiry_date_dl CHECK(expiry_date > issue_date),
    CONSTRAINT driver_licenses_ibfk_1 FOREIGN KEY (id_category) REFERENCES license_categories (id_category),
    CONSTRAINT driver_licenses_ibfk_2 FOREIGN KEY (id_driver) REFERENCES drivers (id_driver)
);

CREATE INDEX idx_driver_licenses_id_category ON driver_licenses (id_category);
CREATE INDEX idx_driver_licenses_id_driver ON driver_licenses (id_driver);

INSERT INTO driver_licenses (id_license, issue_date, expiry_date, description, id_category, id_driver) VALUES
    -- Licencias originales (categorías A2, B1, B3, C1, C2)
    (1, '2022-01-10', '2027-01-10', 'Camión sencillo', 5, 1),
    (2, '2022-03-15', '2025-03-15', 'Bus de pasajeros', 6, 2),
    (3, '2022-06-20', '2027-06-20', 'Tractomula pesada', 7, 3),
    (4, '2022-08-05', '2027-08-05', 'Reparto urbano', 5, 4),
    (5, '2022-11-12', '2025-11-12', 'Carga extrapesada', 7, 5),
    (6, '2023-01-30', '2028-01-30', 'Transporte intermunicipal', 6, 6),
    (7, '2023-02-14', '2028-02-14', 'Furgón mediano', 5, 7),
    (8, '2023-04-10', '2026-04-10', 'Articulado', 7, 8),
    (9, '2023-05-22', '2028-05-22', 'Buseta', 6, 9),
    (10, '2023-07-01', '2028-07-01', 'Estacas', 5, 10),
    (11, '2023-08-15', '2026-08-15', 'Remolque', 7, 11),
    (12, '2023-10-05', '2028-10-05', 'SITP', 6, 12),
    (13, '2023-12-10', '2028-12-10', 'Turbo', 5, 13),
    (14, '2024-01-20', '2027-01-20', 'Cisterna', 7, 14),
    (15, '2024-02-25', '2029-02-25', 'Escolar', 6, 15),
    (16, '2022-01-10', '2027-01-10', 'Categoría moto personal', 2, 1),
    (17, '2022-06-20', '2027-06-20', 'Habilitado para vehículo particular', 3, 3),
    (18, '2022-06-20', '2032-06-20', 'Moto (Vigencia 10 años por ser joven)', 2, 3),
    (19, '2022-11-12', '2025-11-12', 'Recategorización a C1', 5, 5),
    (20, '2023-04-10', '2033-04-10', 'Licencia de moto nueva', 2, 8),
    (21, '2023-07-01', '2028-07-01', 'Complemento particular', 3, 10),
    (22, '2023-10-05', '2033-10-05', 'Maneja moto para llegar al trabajo', 2, 12),
    (23, '2024-02-25', '2029-02-25', 'Equivalencia particular', 3, 15),
    -- Licencias C3 (categoría 8) para todos los conductores
    (24, '2022-01-10', '2032-01-10', 'Habilitación C3 - Vehículo articulado', 8, 1),
    (25, '2022-03-15', '2032-03-15', 'Habilitación C3 - Vehículo articulado', 8, 2),
    (26, '2022-06-20', '2032-06-20', 'Habilitación C3 - Vehículo articulado', 8, 3),
    (27, '2022-08-05', '2032-08-05', 'Habilitación C3 - Vehículo articulado', 8, 4),
    (28, '2022-11-12', '2032-11-12', 'Habilitación C3 - Vehículo articulado', 8, 5),
    (29, '2023-01-30', '2033-01-30', 'Habilitación C3 - Vehículo articulado', 8, 6),
    (30, '2023-02-14', '2033-02-14', 'Habilitación C3 - Vehículo articulado', 8, 7),
    (31, '2023-04-10', '2033-04-10', 'Habilitación C3 - Vehículo articulado', 8, 8),
    (32, '2023-05-22', '2033-05-22', 'Habilitación C3 - Vehículo articulado', 8, 9),
    (33, '2023-07-01', '2033-07-01', 'Habilitación C3 - Vehículo articulado', 8, 10),
    (34, '2023-08-15', '2033-08-15', 'Habilitación C3 - Vehículo articulado', 8, 11),
    (35, '2023-10-05', '2033-10-05', 'Habilitación C3 - Vehículo articulado', 8, 12),
    (36, '2023-12-10', '2033-12-10', 'Habilitación C3 - Vehículo articulado', 8, 13),
    (37, '2024-01-20', '2034-01-20', 'Habilitación C3 - Vehículo articulado', 8, 14),
    (38, '2024-02-25', '2034-02-25', 'Habilitación C3 - Vehículo articulado', 8, 15);

SELECT setval('driver_licenses_id_license_seq', (SELECT MAX(id_license) FROM driver_licenses));

-- =====================================================================
-- Table: maintenances
-- =====================================================================
CREATE TABLE maintenances (
    id_maintenance SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    description VARCHAR(50) DEFAULT NULL,
    maintenance_cost DOUBLE PRECISION NOT NULL,
    id_vehicle INTEGER NOT NULL CHECK(id_vehicle > 0),
    CONSTRAINT maintenances_ibfk_1 FOREIGN KEY (id_vehicle) REFERENCES vehicles (id_vehicle),
	CONSTRAINT cost_positive_chk CHECK(maintenance_cost > 0)
);

CREATE INDEX idx_maintenances_id_vehicle ON maintenances (id_vehicle);

INSERT INTO maintenances (id_maintenance, date, description, maintenance_cost, id_vehicle) VALUES
    (1, '2024-01-10', 'Cambio de aceite', 150.5, 1),
    (2, '2024-01-15', 'Frenos y discos', 450, 2),
    (3, '2024-02-05', 'Llantas delanteras', 300.25, 3),
    (4, '2024-02-12', 'Sincronización', 280, 4),
    (5, '2024-02-20', 'Reparación motor', 1200.8, 5),
    (6, '2024-03-01', 'Suspensión', 350, 6),
    (7, '2024-03-05', 'Alineación', 85, 7),
    (8, '2024-03-10', 'Cambio aceite', 150.5, 8),
    (9, '2024-03-12', 'Sistema eléctrico', 210, 9),
    (10, '2024-03-15', 'Frenos', 420, 10),
    (11, '2024-03-18', 'Filtros aire', 90, 11),
    (12, '2024-03-20', 'Batería nueva', 180, 12),
    (13, '2024-03-22', 'Caja de cambios', 850, 13),
    (14, '2024-03-25', 'Engrase general', 120, 14),
    (15, '2024-03-28', 'Espejos y luces', 75, 15),
    (16, '2024-02-15', 'Cambio de pastillas de frenos', 120, 1),
    (17, '2024-04-10', 'Revisión de suspensión', 210.5, 1),
    (18, '2024-05-05', 'Cambio de aceite y filtros', 145, 1),
    (19, '2024-02-20', 'Rotación de llantas', 60, 2),
    (20, '2024-03-25', 'Limpieza de inyectores', 180, 2),
    (21, '2024-05-12', 'Cambio de kit de embrague', 550, 2),
    (22, '2024-01-10', 'Reparación de luces traseras', 45, 3),
    (23, '2024-03-05', 'Alineación y balanceo', 90, 3),
    (24, '2024-04-20', 'Cambio de batería', 165, 3),
    (25, '2024-02-12', 'Mantenimiento aire acondicionado', 110, 4),
    (26, '2024-04-15', 'Cambio de aceite', 140, 4),
    (27, '2024-05-20', 'Sincronización de motor', 320, 4),
    (28, '2024-01-25', 'Cambio de llantas traseras', 800, 5),
    (29, '2024-03-30', 'Revisión de frenos ABS', 250, 5),
    (30, '2024-05-15', 'Engrase de chasis', 85, 5),
    (31, '2024-02-05', 'Cambio de plumillas', 35, 6),
    (32, '2024-04-22', 'Cambio de aceite', 150, 6),
    (33, '2024-05-25', 'Reparación de radiador', 190, 6),
    (34, '2024-02-28', 'Mantenimiento preventivo', 200, 7),
    (35, '2024-03-15', 'Ajuste de pernos', 50, 7),
    (36, '2024-05-01', 'Cambio de filtros de aire', 75, 7),
    (37, '2024-01-15', 'Sustitución de turbo', 950, 8),
    (38, '2024-04-05', 'Cambio de aceite', 150, 8),
    (39, '2024-05-28', 'Revisión técnica', 120, 8),
    (40, '2024-02-10', 'Pintura de bómper', 220, 9),
    (41, '2024-03-20', 'Cambio de correas', 180, 9),
    (42, '2024-05-10', 'Limpieza de tanque combustible', 130, 9),
    (43, '2024-02-22', 'Cambio de sensor de oxígeno', 95, 10),
    (44, '2024-04-18', 'Alineación', 80, 10),
    (45, '2024-05-22', 'Aceite y valvulina', 190, 10),
    (46, '2024-01-30', 'Ajuste de espejos', 30, 11),
    (47, '2024-03-12', 'Cambio de aceite', 155, 11),
    (48, '2024-05-08', 'Revisión de frenos', 110, 11),
    (49, '2024-02-14', 'Lavado de motor', 40, 12),
    (50, '2024-04-01', 'Cambio de bombillos', 25, 12),
    (51, '2024-05-18', 'Engrase general', 80, 12),
    (52, '2024-01-20', 'Reparación de caja', 1100, 13),
    (53, '2024-03-25', 'Cambio de aceite', 150, 13),
    (54, '2024-05-12', 'Filtro de combustible', 65, 13),
    (55, '2024-02-05', 'Cambio de llanta repuesto', 350, 14),
    (56, '2024-04-10', 'Mantenimiento preventivo', 210, 14),
    (57, '2024-05-28', 'Revisión de suspensión', 240, 14),
    (58, '2024-01-18', 'Scanner electrónico', 70, 15),
    (59, '2024-03-30', 'Cambio de aceite', 150, 15),
    (60, '2024-05-15', 'Cambio de pastillas', 130, 15);

SELECT setval('maintenances_id_maintenance_seq', (SELECT MAX(id_maintenance) FROM maintenances));

-- =====================================================================
-- Table: routes
-- =====================================================================
CREATE TABLE routes (
    id_route SERIAL PRIMARY KEY,
    origin VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    distance DOUBLE PRECISION DEFAULT NULL,
    fuel_consumed DOUBLE PRECISION DEFAULT NULL,
    travel_date DATE NOT NULL,
    status route_status DEFAULT 'IN_PROGRESS',
    id_vehicle INTEGER NOT NULL,
    id_driver INTEGER NOT NULL,
    CONSTRAINT routes_ibfk_1 FOREIGN KEY (id_vehicle) REFERENCES vehicles (id_vehicle),
    CONSTRAINT routes_ibfk_2 FOREIGN KEY (id_driver) REFERENCES drivers (id_driver),
    CONSTRAINT distance_positive_chk CHECK(distance > 0),
    CONSTRAINT fuel_consumed_after_route_chk CHECK(fuel_consumed > 0),
    CONSTRAINT id_vehicle_exists_chk CHECK(id_vehicle > 0),
    CONSTRAINT id_driver_exists_chk CHECK(id_driver > 0)
);

CREATE INDEX idx_routes_id_vehicle ON routes (id_vehicle);
CREATE INDEX idx_routes_id_driver ON routes (id_driver);

INSERT INTO routes (id_route, origin, destination, distance, fuel_consumed, travel_date, status, id_vehicle, id_driver) VALUES
    (1, 'Bogotá', 'Medellín', 420, 45, '2024-03-01', 'COMPLETED', 1, 1),
    (2, 'Medellín', 'Cali', 450, 50, '2024-03-02', 'COMPLETED', 2, 2),
    (3, 'Cali', 'Buenaventura', 120, 15, '2024-03-03', 'COMPLETED', 3, 3),
    (4, 'Bogotá', 'Villavicencio', 125, 18, '2024-03-04', 'COMPLETED', 4, 4),
    (5, 'Barranquilla', 'Cartagena', 120, 14, '2024-03-05', 'COMPLETED', 5, 5),
    (6, 'Bucaramanga', 'Cúcuta', 200, 28, '2024-03-06', 'COMPLETED', 6, 6),
    (7, 'Pereira', 'Armenia', 45, 6, '2024-03-07', 'COMPLETED', 7, 7),
    (8, 'Manizales', 'Bogotá', 300, 38, '2024-03-08', 'COMPLETED', 8, 8),
    (9, 'Neiva', 'Pitalito', 180, 22, '2024-03-09', 'COMPLETED', 9, 9),
    (10, 'Ibagué', 'Armenia', 85, 12, '2024-03-10', 'COMPLETED', 10, 10),
    (11, 'Santa Marta', 'Riohacha', 170, 20, '2024-03-11', 'COMPLETED', 11, 11),
    (12, 'Montería', 'Sincelejo', 90, 10, '2024-03-12', 'COMPLETED', 12, 12),
    (13, 'Pasto', 'Ipiales', 80, 12, '2024-03-13', 'COMPLETED', 13, 13),
    (14, 'Tunja', 'Sogamoso', 80, 9, '2024-03-14', 'COMPLETED', 14, 14),
    (15, 'Popayán', 'Cali', 140, 16, '2024-03-15', 'COMPLETED', 15, 15),
    (16, 'Bogotá', 'Tunja', 140, 15, '2024-01-05', 'COMPLETED', 1, 5),
    (17, 'Medellín', 'Pereira', 215, 25, '2024-01-07', 'COMPLETED', 2, 10),
    (18, 'Cali', 'Pastó', 380, 42, '2024-01-10', 'COMPLETED', 3, 15),
    (19, 'Barranquilla', 'Santa Marta', 95, 10, '2024-01-12', 'COMPLETED', 4, 1),
    (20, 'Bucaramanga', 'Aguachica', 170, 20, '2024-01-15', 'COMPLETED', 5, 2),
    (21, 'Villavicencio', 'Bogotá', 125, 18, '2024-01-18', 'COMPLETED', 6, 3),
    (22, 'Manizales', 'Medellín', 200, 24, '2024-01-20', 'COMPLETED', 7, 4),
    (23, 'Cúcuta', 'Bucaramanga', 200, 30, '2024-01-22', 'COMPLETED', 8, 6),
    (24, 'Sincelejo', 'Montería', 90, 11, '2024-01-25', 'COMPLETED', 9, 7),
    (25, 'Valledupar', 'Barranquilla', 300, 35, '2024-01-28', 'COMPLETED', 10, 8),
    (26, 'Cartagena', 'Barranquilla', 120, 14, '2024-02-02', 'COMPLETED', 11, 9),
    (27, 'Bogotá', 'Cali', 460, 52, '2024-02-05', 'COMPLETED', 12, 11),
    (28, 'Neiva', 'Bogotá', 310, 35, '2024-02-08', 'COMPLETED', 13, 12),
    (29, 'Pereira', 'Quibdó', 230, 32, '2024-02-12', 'COMPLETED', 14, 13),
    (30, 'Ibagué', 'Bogotá', 200, 22, '2024-02-15', 'COMPLETED', 15, 14),
    (31, 'Medellín', 'Montería', 400, 48, '2024-02-18', 'COMPLETED', 1, 10),
    (32, 'Cali', 'Popayán', 140, 16, '2024-02-20', 'COMPLETED', 2, 1),
    (33, 'Bogotá', 'Yopal', 335, 40, '2024-02-22', 'COMPLETED', 3, 2),
    (34, 'Barranquilla', 'Sincelejo', 220, 25, '2024-02-25', 'COMPLETED', 4, 3),
    (35, 'Riohacha', 'Santa Marta', 170, 20, '2024-02-27', 'COMPLETED', 5, 4),
    (36, 'Bucaramanga', 'Bogotá', 400, 45, '2024-03-05', 'COMPLETED', 6, 5),
    (37, 'Pereira', 'Cali', 210, 24, '2024-03-08', 'COMPLETED', 7, 6),
    (38, 'Tunja', 'Bucaramanga', 280, 32, '2024-03-10', 'COMPLETED', 8, 7),
    (39, 'Medellín', 'Apartadó', 310, 38, '2024-03-12', 'COMPLETED', 9, 8),
    (40, 'Bogotá', 'Honda', 150, 18, '2024-03-14', 'COMPLETED', 10, 9),
    (41, 'Cali', 'Ipiales', 470, 55, '2024-03-16', 'COMPLETED', 11, 11),
    (42, 'Villavicencio', 'Puerto López', 85, 10, '2024-03-18', 'COMPLETED', 12, 12),
    (43, 'Cartagena', 'Magangué', 240, 28, '2024-03-20', 'COMPLETED', 13, 13),
    (44, 'Manizales', 'Pereira', 55, 7, '2024-03-22', 'COMPLETED', 14, 14),
    (45, 'Bucaramanga', 'Barrancabermeja', 115, 14, '2024-03-25', 'COMPLETED', 15, 15),
    (46, 'Bogotá', 'Girardot', 140, 15, '2024-03-26', 'COMPLETED', 1, 1),
    (47, 'Girardot', 'Ibagué', 80, 10, '2024-03-27', 'COMPLETED', 1, 1),
    (48, 'Ibagué', 'Armenia', 85, 12, '2024-03-28', 'COMPLETED', 1, 1),
    (49, 'Armenia', 'Pereira', 45, 6, '2024-03-29', 'COMPLETED', 1, 1),
    (50, 'Pereira', 'Manizales', 55, 8, '2024-03-30', 'COMPLETED', 1, 1),
    (51, 'Cartagena', 'Sincelejo', 190, 22, '2024-03-26', 'COMPLETED', 2, 2),
    (52, 'Sincelejo', 'Caucasia', 150, 18, '2024-03-28', 'COMPLETED', 2, 2),
    (53, 'Medellín', 'Bello', 20, 3, '2024-03-26', 'COMPLETED', 3, 3),
    (54, 'Bello', 'Barbosa', 30, 4, '2024-03-27', 'COMPLETED', 3, 3),
    (55, 'Barbosa', 'Puerto Berrío', 170, 22, '2024-03-29', 'COMPLETED', 3, 3),
    (56, 'Bogotá', 'Chía', 25, 3, '2024-04-01', 'COMPLETED', 1, 1),
    (57, 'Chía', 'Zipaquirá', 30, 4, '2024-04-02', 'COMPLETED', 1, 1),
    (58, 'Medellín', 'Guatapé', 80, 10, '2024-04-03', 'COMPLETED', 2, 2),
    (59, 'Cali', 'Yumbo', 20, 3, '2024-04-04', 'COMPLETED', 3, 3),
    (60, 'Barranquilla', 'Soledad', 15, 2, '2024-04-05', 'COMPLETED', 4, 4),
    (61, 'Bucaramanga', 'Girón', 12, 2, '2024-04-06', 'COMPLETED', 5, 5),
    (62, 'Bogotá', 'Anapoima', 90, 11, '2024-04-07', 'COMPLETED', 6, 6),
    (63, 'Medellín', 'Sabaneta', 15, 2, '2024-04-08', 'COMPLETED', 7, 7),
    (64, 'Pereira', 'Santa Rosa', 15, 2, '2024-04-09', 'COMPLETED', 8, 8),
    (65, 'Manizales', 'Chinchiná', 25, 4, '2024-04-10', 'COMPLETED', 9, 9),
    (66, 'Cartagena', 'Sincelejo', 190, 23, '2024-04-12', 'COMPLETED', 10, 10),
    (67, 'Santa Marta', 'Barranquilla', 95, 11, '2024-04-14', 'COMPLETED', 11, 11),
    (68, 'Cúcuta', 'Pamplona', 75, 12, '2024-04-15', 'COMPLETED', 12, 12),
    (69, 'Villavicencio', 'Acacías', 28, 4, '2024-04-16', 'COMPLETED', 13, 13),
    (70, 'Neiva', 'Espinal', 160, 19, '2024-04-17', 'COMPLETED', 14, 14),
    (71, 'Popayán', 'Pastó', 250, 30, '2024-04-18', 'COMPLETED', 15, 15),
    (72, 'Bogotá', 'Facatativá', 45, 6, '2024-04-20', 'COMPLETED', 1, 10),
    (73, 'Medellín', 'La Ceja', 41, 5, '2024-04-21', 'COMPLETED', 2, 2),
    (74, 'Bucaramanga', 'Floridablanca', 10, 1, '2024-04-22', 'COMPLETED', 8, 3),
    (75, 'Cali', 'Palmira', 30, 4, '2024-04-23', 'COMPLETED', 11, 15),
    (76, 'Medellín', 'Santuario', 60, 7, '2024-04-24', 'COMPLETED', 2, 2),
    (77, 'Santuario', 'Doradal', 110, 13, '2024-04-25', 'COMPLETED', 2, 2),
    (78, 'Doradal', 'Puerto Salgar', 80, 9, '2024-04-26', 'COMPLETED', 2, 2),
    (79, 'Puerto Salgar', 'Bogotá', 190, 22, '2024-04-27', 'COMPLETED', 2, 2),
    (80, 'Puerto Berrío', 'Berrío Alto', 40, 5, '2024-04-24', 'COMPLETED', 3, 3),
    (81, 'Berrío Alto', 'Remedios', 90, 12, '2024-04-25', 'COMPLETED', 3, 3),
    (82, 'Remedios', 'Segovia', 15, 2, '2024-04-26', 'COMPLETED', 3, 3),
    (83, 'Segovia', 'Medellín', 200, 26, '2024-04-27', 'COMPLETED', 3, 3),
    (84, 'Medellín', 'Envigado', 12, 1, '2024-04-28', 'COMPLETED', 3, 3),
    (85, 'SITP Terminal', 'Suba', 25, 3, '2024-04-24', 'COMPLETED', 12, 12),
    (86, 'Suba', 'Usaquén', 15, 2, '2024-04-25', 'COMPLETED', 12, 12),
    (87, 'Usaquén', 'Fontibón', 20, 2, '2024-04-26', 'COMPLETED', 12, 12),
    (88, 'Fontibón', 'Bosa', 18, 2, '2024-04-27', 'COMPLETED', 12, 12),
    (89, 'Bogotá', 'Mosquera', 22, 3, '2024-04-24', 'COMPLETED', 4, 4),
    (90, 'Mosquera', 'Madrid', 10, 1, '2024-04-25', 'COMPLETED', 4, 4),
    (91, 'Madrid', 'Facatativá', 15, 2, '2024-04-26', 'COMPLETED', 4, 4),
    (92, 'Facatativá', 'Villeta', 60, 8, '2024-04-27', 'COMPLETED', 4, 4),
    (93, 'Villeta', 'Guaduas', 35, 5, '2024-04-28', 'COMPLETED', 4, 4),
    (94, 'Yopal', 'Aguazul', 28, 3, '2024-04-24', 'COMPLETED', 10, 8),
    (95, 'Aguazul', 'Tauramena', 45, 5, '2024-04-25', 'COMPLETED', 10, 8),
    (96, 'Tauramena', 'Monterrey', 35, 4, '2024-04-26', 'COMPLETED', 10, 8),
    (97, 'Bogotá', 'Tunja', 140, 16, '2024-05-02', 'COMPLETED', 1, 1),
    (98, 'Tunja', 'Sogamoso', 80, 9, '2024-05-05', 'COMPLETED', 1, 1),
    (99, 'Medellín', 'Rionegro', 35, 4, '2024-05-01', 'COMPLETED', 2, 2),
    (100, 'Rionegro', 'La Ceja', 20, 2, '2024-05-03', 'COMPLETED', 2, 2),
    (101, 'La Ceja', 'Medellín', 40, 5, '2024-05-06', 'COMPLETED', 2, 2),
    (102, 'Cali', 'Buenaventura', 115, 15, '2024-05-02', 'COMPLETED', 3, 3),
    (103, 'Buenaventura', 'Buga', 125, 17, '2024-05-04', 'COMPLETED', 3, 3),
    (104, 'Barranquilla', 'Cartagena', 105, 12, '2024-05-02', 'COMPLETED', 4, 4),
    (105, 'Cartagena', 'Santa Marta', 220, 26, '2024-05-07', 'COMPLETED', 4, 4),
    (106, 'Bogotá', 'Ibagué', 200, 25, '2024-05-01', 'COMPLETED', 8, 8),
    (107, 'Ibagué', 'Armenia', 85, 11, '2024-05-03', 'COMPLETED', 8, 8),
    (108, 'Armenia', 'Pereira', 45, 6, '2024-05-04', 'COMPLETED', 8, 8),
    (109, 'Pereira', 'Manizales', 55, 7, '2024-05-06', 'COMPLETED', 8, 8),
    (110, 'Manizales', 'Medellín', 190, 24, '2024-05-08', 'COMPLETED', 8, 8),
    (111, 'Villavicencio', 'Puerto López', 85, 11, '2024-05-02', 'COMPLETED', 10, 10),
    (112, 'Puerto López', 'Villavicencio', 85, 11, '2024-05-05', 'COMPLETED', 10, 10),
    (113, 'Bucaramanga', 'San Gil', 100, 14, '2024-05-03', 'COMPLETED', 12, 12),
    (114, 'San Gil', 'Socorro', 25, 3, '2024-05-06', 'COMPLETED', 12, 12),
    (115, 'Cúcuta', 'Ocaña', 200, 26, '2024-05-02', 'COMPLETED', 15, 15),
    (116, 'Ocaña', 'Aguachica', 50, 7, '2024-05-04', 'COMPLETED', 15, 15),
    (117, 'Aguachica', 'Valledupar', 170, 21, '2024-05-06', 'COMPLETED', 15, 15),
    (118, 'Valledupar', 'Bosconia', 95, 11, '2024-05-08', 'COMPLETED', 15, 15),
    (119, 'Bogotá', 'Santa Marta', 950, 121, '2026-03-01', 'COMPLETED', 1, 1),
    (120, 'Santa Marta', 'Medellín', 830, 105, '2026-03-05', 'COMPLETED', 2, 1),
    (121, 'Medellín', 'Cali', 420, 55, '2026-03-10', 'COMPLETED', 1, 1),
    (122, 'Cali', 'Ipiales', 470, 60, '2026-03-02', 'COMPLETED', 3, 2),
    (123, 'Ipiales', 'Bogotá', 840, 110, '2026-03-08', 'COMPLETED', 4, 2),
    (124, 'Bogotá', 'Barranquilla', 1000, 130, '2026-03-15', 'COMPLETED', 3, 2),
    (125, 'Bucaramanga', 'Cartagena', 650, 85, '2026-03-04', 'COMPLETED', 5, 3),
    (126, 'Cartagena', 'Pereira', 800, 95, '2026-03-12', 'COMPLETED', 5, 3),
    (127, 'Pereira', 'Villavicencio', 350, 45, '2026-03-18', 'COMPLETED', 2, 3),
    (128, 'Villavicencio', 'Montería', 880, 115, '2026-03-22', 'COMPLETED', 1, 3),
    (129, 'Cúcuta', 'Bogotá', 550, 70, '2026-03-06', 'COMPLETED', 4, 4),
    (130, 'Bogotá', 'Neiva', 300, 35, '2026-03-11', 'COMPLETED', 2, 4),
    (131, 'Neiva', 'Pasto', 450, 58, '2026-03-16', 'COMPLETED', 3, 4),
    (132, 'Pasto', 'Cali', 380, 48, '2026-03-20', 'COMPLETED', 5, 4),
    (133, 'Cali', 'Buenaventura', 120, 15, '2026-03-25', 'COMPLETED', 1, 4);

SELECT setval('routes_id_route_seq', (SELECT MAX(id_route) FROM routes));

CREATE TABLE user_info (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'ROLE_ADMIN'
);

-- Insert initial administrator user (Password: admin123)
INSERT INTO user_info (username, password, role) 
VALUES ('admin', '$2a$10$8.UnVuG9HHgffUDAlk8qfOUVGkqRzgVymGe07xD001kC2hx.h1g7u', 'ROLE_ADMIN');


-- =====================================================================
-- FUNCIÓN HELPER: Evalúa km desde último mantenimiento
-- Se llama únicamente al completar una ruta
-- =====================================================================
CREATE OR REPLACE FUNCTION evaluate_required_maintenance(p_id_vehicle INTEGER)
RETURNS VOID AS $$
DECLARE
    v_km_since_last_maintenance DOUBLE PRECISION;
    v_limit_km CONSTANT DOUBLE PRECISION := 10000.0;
BEGIN
    SELECT COALESCE(SUM(r.distance), 0) INTO v_km_since_last_maintenance
    FROM routes r
    WHERE r.id_vehicle = p_id_vehicle
      AND r.status = 'COMPLETED'
      AND r.travel_date > COALESCE(
          (SELECT MAX(m.date) FROM maintenances m WHERE m.id_vehicle = p_id_vehicle),
          '1900-01-01'::date
      );

    IF v_km_since_last_maintenance >= v_limit_km THEN
        UPDATE vehicles
        SET status = 'MAINTENANCE_REQUIRED'::vehicle_status
        WHERE id_vehicle = p_id_vehicle
          AND status NOT IN ('MAINTENANCE', 'MAINTENANCE_REQUIRED');

        RAISE NOTICE 'Vehicle % marked as MAINTENANCE_REQUIRED (Km since last maintenance: %)',
                     p_id_vehicle, v_km_since_last_maintenance;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- =====================================================================
-- Regla: Cuando se inserta una nueva ruta en routes, cambia automáticamente
-- el status del vehículo y del conductor involucrados a 'IN_ROUTE'.
-- =====================================================================
CREATE OR REPLACE FUNCTION insert_routes_status_update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'IN_PROGRESS' THEN
        UPDATE vehicles
        SET status = 'IN_ROUTE'::vehicle_status
        WHERE id_vehicle = NEW.id_vehicle;

        UPDATE drivers
        SET status = 'IN_ROUTE'::driver_status
        WHERE id_driver = NEW.id_driver;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_route_registered
AFTER INSERT ON routes
FOR EACH ROW
EXECUTE FUNCTION insert_routes_status_update();

-- =====================================================================
-- Regla: Cada vez que se registra un viaje completado en routes,
-- actualiza el campo mileage del vehículo sumándole la distance de la nueva ruta.
-- =====================================================================
CREATE OR REPLACE FUNCTION update_completed_route()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'UPDATE' AND NEW.status = 'COMPLETED' AND OLD.status IS DISTINCT FROM NEW.status)
       OR (TG_OP = 'INSERT' AND NEW.status = 'COMPLETED') THEN

        UPDATE vehicles
        SET mileage = mileage + NEW.distance,
            status = 'AVAILABLE'::vehicle_status
        WHERE id_vehicle = NEW.id_vehicle;

        UPDATE drivers
        SET status = 'AVAILABLE'::driver_status
        WHERE id_driver = NEW.id_driver;

        PERFORM evaluate_required_maintenance(NEW.id_vehicle);

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_route_completed
AFTER INSERT OR UPDATE ON routes
FOR EACH ROW
EXECUTE FUNCTION update_completed_route();

-- =====================================================================
-- Regla: Antes de insertar un viaje en routes,
-- verifica si el conductor tiene al menos una licencia C3 activa.
-- Tambien valida que el vehiculo y el conductor estén disponibles para viajar
-- =====================================================================
CREATE OR REPLACE FUNCTION fn_check_valid_route()
RETURNS TRIGGER AS $$
DECLARE
    v_valid_license_count INTEGER;
    v_vehicle_status vehicle_status;
    d_driver_status driver_status;
BEGIN
    -- 1. VALIDACIÓN DE FECHA: No pasado, máximo 30 días a futuro
    IF NEW.travel_date < CURRENT_DATE THEN
        RAISE EXCEPTION 'Cannot register routes with past dates (Travel date: %, Today: %).',
                        NEW.travel_date, CURRENT_DATE;
    ELSIF NEW.travel_date > (CURRENT_DATE + INTERVAL '30 days') THEN
        RAISE EXCEPTION 'Cannot schedule routes more than 30 days into the future (Travel date: %).',
                        NEW.travel_date;
    END IF;

    -- 2. VALIDACIÓN DE LICENCIA C3 VIGENTE
    SELECT COUNT(*) INTO v_valid_license_count
    FROM driver_licenses dl
    JOIN license_categories lc ON dl.id_category = lc.id_category
    WHERE dl.id_driver = NEW.id_driver
      AND lc.category_name = 'C3'
      AND dl.expiry_date >= NEW.travel_date;

    IF v_valid_license_count = 0 THEN
        RAISE EXCEPTION 'The driver with ID % does not have a valid C3 license for the date %.',
                        NEW.id_driver, NEW.travel_date;
    END IF;

    -- 3. VALIDACIÓN DE DISPONIBILIDAD DEL VEHÍCULO
    SELECT status INTO v_vehicle_status
    FROM vehicles
    WHERE id_vehicle = NEW.id_vehicle;

    IF v_vehicle_status NOT IN ('AVAILABLE') THEN
        RAISE EXCEPTION 'The vehicle with ID % is not available (Current status: %).', 
                        NEW.id_vehicle, v_vehicle_status;
    END IF;

    -- 4. VALIDACIÓN DE DISPONIBILIDAD DEL CONDUCTOR
    SELECT status INTO d_driver_status
    FROM drivers
    WHERE id_driver = NEW.id_driver;

    IF d_driver_status NOT IN ('AVAILABLE') THEN
        RAISE EXCEPTION 'The driver with ID % is not available (Current status: %).', 
                        NEW.id_driver, d_driver_status;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_check_valid_route
BEFORE INSERT ON routes
FOR EACH ROW
EXECUTE FUNCTION fn_check_valid_route();

-- =====================================================================
-- Procedimiento: Completar una ruta actualizando status, distance y fuel_consumed
-- para una ruta con id_route
-- =====================================================================
CREATE OR REPLACE PROCEDURE complete_route(
    p_id_route INTEGER,
    p_fuel_consumed DOUBLE PRECISION,
    p_distance DOUBLE PRECISION DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM routes r WHERE r.id_route = p_id_route AND r.status = 'IN_PROGRESS') THEN
        RAISE EXCEPTION 'The route with ID % does not exist or is not in progress.', p_id_route;
    END IF;

    UPDATE routes
    SET status = 'COMPLETED',
        fuel_consumed = p_fuel_consumed,
        distance = COALESCE(p_distance, distance)
    WHERE id_route = p_id_route;

    RAISE NOTICE 'Route with ID % completed successfully.', p_id_route;
END;
$$;


-- =====================================================================
-- Procedimiento: Registrar un mantenimiento
-- =====================================================================

CREATE OR REPLACE PROCEDURE register_maintenance(
	p_id_vehicle INTEGER,
	p_cost DOUBLE PRECISION,
	p_description VARCHAR(100) DEFAULT NULL
	
)
LANGUAGE plpgsql
AS $$
DECLARE
	v_vehicle_status vehicle_status;
BEGIN
	SELECT status INTO v_vehicle_status
	FROM vehicles
	WHERE id_vehicle = p_id_vehicle;

	IF v_vehicle_status IN ('MAINTENANCE_REQUIRED', 'AVAILABLE') THEN
		INSERT INTO maintenances (date, description, maintenance_cost, id_vehicle) 
		VALUES (CURRENT_DATE, p_description, p_cost, p_id_vehicle);
	
		UPDATE vehicles
		SET status = 'MAINTENANCE'::vehicle_status
		WHERE id_vehicle = p_id_vehicle;

		RAISE NOTICE 'the vehicle with ID % is in maintenance.', p_id_vehicle;
	ELSE
		RAISE EXCEPTION 'The vehicle with ID % cannot enter maintenance because its status is %.', 
                        p_id_vehicle, v_vehicle_status;
	END IF;
END;
$$;


-- =====================================================================
-- Procedimiento: Finalizar un mantenimiento en proceso
-- =====================================================================
CREATE OR REPLACE PROCEDURE finish_maintenance (
	p_id_vehicle INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
	v_vehicle_status vehicle_status;
BEGIN
	SELECT status INTO v_vehicle_status
	FROM vehicles
	WHERE id_vehicle = p_id_vehicle;

	IF v_vehicle_status = 'MAINTENANCE' THEN
		UPDATE vehicles
		SET status = 'AVAILABLE'::vehicle_status
		WHERE id_vehicle = p_id_vehicle;
		
		RAISE NOTICE 'Maintenance completed. Vehicle % is now AVAILABLE.', p_id_vehicle;
    ELSE
        RAISE EXCEPTION 'Vehicle % cannot finish maintenance because its current status is %.', 
                        p_id_vehicle, v_vehicle_status;
    END IF;
	
END;
$$;


-- =====================================================================
-- Procedimiento: Crear una nueva ruta
-- =====================================================================
CREATE OR REPLACE PROCEDURE create_route(
    p_origin VARCHAR(50),
    p_destination VARCHAR(50),
    p_id_vehicle INTEGER,
    p_id_driver INTEGER,
    p_travel_date DATE DEFAULT CURRENT_DATE,
    p_distance DOUBLE PRECISION DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    
    INSERT INTO routes (origin, destination, distance, travel_date, id_vehicle, id_driver, status)
    VALUES (p_origin, p_destination, p_distance, p_travel_date, p_id_vehicle, p_id_driver, 'IN_PROGRESS');
    RAISE NOTICE 'Route from % to % assigned to Vehicle % and Driver % created successfully.',
                 p_origin, p_destination, p_id_vehicle, p_id_driver;
END;
$$;

-- =====================================================================
-- VISTA: Para analizar costos mensuales por vehículo (reporte, no trigger)
-- =====================================================================
CREATE OR REPLACE VIEW vw_monthly_maintenance_cost AS
SELECT
    v.id_vehicle,
    v.number_plate,
    v.brand,
    DATE_TRUNC('month', m.date) AS month,
    SUM(m.maintenance_cost) AS total_cost,
    COUNT(m.id_maintenance) AS total_maintenances,
    CASE
        WHEN SUM(m.maintenance_cost) >= 1000 THEN '⚠ EXCEDE LÍMITE'
        ELSE '✓ OK'
    END AS cost_alert
FROM vehicles v
JOIN maintenances m ON v.id_vehicle = m.id_vehicle
GROUP BY v.id_vehicle, v.number_plate, v.brand, DATE_TRUNC('month', m.date)
ORDER BY month DESC, total_cost DESC;



COMMIT;
