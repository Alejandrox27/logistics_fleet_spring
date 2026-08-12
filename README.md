# Logistic Fleet API

A RESTful API designed for managing commercial logistics fleets, drivers, routes, and vehicle maintenance. Built using Spring Boot, PostgreSQL, and Spring Security.

## Table of Contents

- [Overview](#overview)
- [Technologies](#technologies)
- [Architecture & Key Features](#architecture--key-features)
- [Prerequisites](#prerequisites)
- [Database Setup](#database-setup)
- [Application Configuration](#application-configuration)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
- [Authentication & Security](#authentication--security)

---

## Overview

The **Logistic Fleet API** provides a backend system for managing logistics operations. It handles vehicle availability, driver licensing validation (enforcing active C3 category licenses for Heavy Transport routes), route execution tracking, vehicle mileage accumulation, automated maintenance alerts, and cost reporting.

---

### Technologies

- **Java 25** (Compatibility with Java 17+)
- **Spring Boot 3.4**
- **Spring Data JPA / Hibernate**
- **Spring Security** (Stateless JWT Authentication & Role-Based Access Control)
- **JJWT (io.jsonwebtoken)** (JSON Web Token generation & validation)
- **PostgreSQL** (Relational Database)
- **Lombok**
- **Maven**

---

## Architecture & Key Features

- **Automated Database Triggers & Stored Procedures**:
  - `tg_check_valid_route`: Enforces driver license validity (C3 category), vehicle availability, and travel date constraints (non-past, max 30 days future).
  - `tg_route_registered`: Automatically transitions vehicle and driver statuses to `IN_ROUTE` upon scheduling.
  - `tg_route_completed`: Updates cumulative mileage, transitions vehicle and driver statuses back to `AVAILABLE`, and triggers evaluation for maintenance requirements (> 10,000 km since last service).
  - Stored Procedures: `create_route`, `complete_route`, `register_maintenance`, `finish_maintenance`.
- **Database Views**:
  - `vw_monthly_maintenance_cost`: Groups monthly maintenance expenses by vehicle and flags cost threshold overruns.
- **Spring Security & Stateless JWT Layer**:
  - Public read-only access (`GET`) for catalog and status queries.
  - Public authentication endpoint (`POST /v1/auth/login`).
  - Protected modification operations (`POST`, `PUT`, `PATCH`, `DELETE`) requiring valid JWT Bearer Token with `ROLE_ADMIN` authority.
  - Password hashing using `BCryptPasswordEncoder`.

---

## Prerequisites

Before running the application, ensure you have the following installed:

- **JDK 17** or higher
- **Maven 3.8+** (or use the included `mvnw` wrapper)
- **PostgreSQL 12+**
- **pgAdmin 4** (optional, for DB administration)

---

## Database Setup

1. Open PostgreSQL (via psql or pgAdmin) and create the database:

   ```sql
   CREATE DATABASE logistics_fleet_db;
   ```

2. Execute the main schema DDL script to create custom ENUM types, tables, triggers, and stored procedures.

3. Create the user authentication table and insert the default administrator user:

   ```sql
   CREATE TABLE user_info (
       id_user SERIAL PRIMARY KEY,
       username VARCHAR(50) NOT NULL UNIQUE,
       password VARCHAR(255) NOT NULL,
       role VARCHAR(50) NOT NULL DEFAULT 'ROLE_ADMIN'
   );

   -- Insert initial administrator user (Password: admin123)
   INSERT INTO user_info (username, password, role) 
   VALUES ('admin', '$2a$10$8.UnVuG9HHgffUDAlk8qfOUVGkqRzgVymGe07xD001kC2hx.h1g7u', 'ROLE_ADMIN');
   ```

---

## Application Configuration

The database credentials are **not** hardcoded in the repository. You must provide your own PostgreSQL username and password using one of the following methods:

### Option 1: Environment Variables (Recommended)

Set the following environment variables on your system before running the application:

```bash
# Windows (PowerShell)
$env:DB_USERNAME="postgres"
$env:DB_PASSWORD="your_postgres_password"

# Linux / macOS
export DB_USERNAME=postgres
export DB_PASSWORD=your_postgres_password
```

### Option 2: Edit `application.properties` directly

Open `src/main/resources/application.properties` and replace the placeholder values with your actual credentials:

```properties
spring.datasource.username=postgres
spring.datasource.password=your_postgres_password
```

> **Important:** If you modify `application.properties` with your real password, make sure you do **not** commit it to a public repository.

---

## Running the Application

To start the server locally, run the following command in the project root directory:

```bash
# Using Maven Wrapper (Windows)
.\mvnw spring-boot:run

# Using Maven Wrapper (Linux/macOS)
./mvnw spring-boot:run
```

The application will start on `http://localhost:8080`.

---

## API Endpoints

### Authentication (`/v1/auth`)

| Method | Endpoint | Description | Access |
| :--- | :--- | :--- | :--- |
| `POST` | `/v1/auth/login` | Authenticate user & receive JWT Bearer Token | Public |

### Drivers (`/v1/drivers`)

| Method | Endpoint | Description | Access |
| :--- | :--- | :--- | :--- |
| `GET` | `/v1/drivers` | Retrieve all drivers | Public |
| `GET` | `/v1/drivers/{id}` | Retrieve driver by ID | Public |
| `GET` | `/v1/drivers/licenses-categories` | List license categories | Public |
| `POST` | `/v1/drivers` | Register a new driver | Admin (JWT) |
| `PUT` | `/v1/drivers/{id}` | Update driver information | Admin (JWT) |
| `PATCH` | `/v1/drivers/add-license` | Assign a new license to a driver | Admin (JWT) |
| `DELETE` | `/v1/drivers/{id}` | Delete a driver | Admin (JWT) |

### Vehicles (`/v1/vehicles`)

| Method | Endpoint | Description | Access |
| :--- | :--- | :--- | :--- |
| `GET` | `/v1/vehicles` | Retrieve all vehicles | Public |
| `GET` | `/v1/vehicles/{id}` | Retrieve vehicle by ID | Public |
| `GET` | `/v1/vehicles/maintenances/cost` | Retrieve monthly maintenance cost view report | Public |
| `POST` | `/v1/vehicles` | Register a new vehicle | Admin (JWT) |
| `PUT` | `/v1/vehicles/{id}` | Update vehicle details | Admin (JWT) |
| `POST` | `/v1/vehicles/{id}/maintenances` | Register maintenance entry for a vehicle | Admin (JWT) |
| `PATCH` | `/v1/vehicles/{id}/maintenances/finish` | Mark vehicle maintenance as finished | Admin (JWT) |
| `DELETE` | `/v1/vehicles/{id}` | Delete a vehicle | Admin (JWT) |

### Routes (`/v1/routes`)

| Method | Endpoint | Description | Access |
| :--- | :--- | :--- | :--- |
| `GET` | `/v1/routes` | Retrieve all routes | Public |
| `GET` | `/v1/routes/{id}` | Retrieve route by ID | Public |
| `POST` | `/v1/routes` | Create and start a new route (executes `create_route`) | Admin (JWT) |
| `PATCH` | `/v1/routes/{id}` | Complete an in-progress route (executes `complete_route`) | Admin (JWT) |
| `PUT` | `/v1/routes/{id}` | Update route details | Admin (JWT) |
| `DELETE` | `/v1/routes/{id}` | Delete a route record | Admin (JWT) |

---

## Authentication & Security

The API uses **Stateless JSON Web Token (JWT) Authentication**.

1. **Obtain JWT Token**: Send a `POST` request to `/v1/auth/login` with your credentials:
   ```json
   {
     "username": "admin",
     "password": "admin123"
   }
   ```
2. **Access Protected Endpoints**: Copy the returned `token` string and include it in the HTTP `Authorization` header for protected requests (`POST`, `PUT`, `PATCH`, `DELETE`):
   ```http
   Authorization: Bearer <YOUR_JWT_TOKEN>
   ```

### Default Credentials

- **Username**: `admin`
- **Password**: `admin123`

