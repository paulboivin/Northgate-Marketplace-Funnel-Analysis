-- Northgate Marketplace Database Schema
-- Creating all four tables with primary and foreign key constraints.

-- Table 1: Products
-- This is the reference table for all products in the catalog.
CREATE TABLE IF NOT EXISTS products (
    product_id   INTEGER PRIMARY KEY,
    product_name TEXT    NOT NULL,
    category     TEXT    NOT NULL,
    base_price   REAL    NOT NULL
);

-- Table 2: Sessions
-- One record is created per user visit to the marketplace.
CREATE TABLE IF NOT EXISTS sessions (
    session_id   INTEGER PRIMARY KEY,
    session_date DATE    NOT NULL,
    device_type  TEXT    NOT NULL,
    user_id      INTEGER NOT NULL
);

-- Table 3: Events
-- One record is created per funnel action taken during a session.
-- This is the central analytical table linking sessions to products.
CREATE TABLE IF NOT EXISTS events (
    event_id        INTEGER PRIMARY KEY,
    session_id      INTEGER REFERENCES sessions(session_id),
    product_id      INTEGER REFERENCES products(product_id),
    event_type      TEXT    NOT NULL,
    event_timestamp DATETIME NOT NULL,
    price_at_event  REAL
);

-- Table 4: Orders
-- One record is created per completed purchase transaction.
CREATE TABLE IF NOT EXISTS orders (
    order_id    INTEGER PRIMARY KEY,
    session_id  INTEGER NOT NULL REFERENCES sessions(session_id),
    product_id  INTEGER NOT NULL REFERENCES products(product_id),
    order_date  DATE    NOT NULL,
    quantity    INTEGER NOT NULL,
    unit_price  REAL    NOT NULL,
    order_value REAL    NOT NULL
);
