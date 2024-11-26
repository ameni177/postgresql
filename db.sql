CREATE DATABASE IF NOT EXIST "pizza_db"

-- Karte


CREATE TABLE "karte" (
    id SERIAL PRIMARY KEY,             -- Automatisch inkrementierende eindeutige ID
    pizza VARCHAR(255) NOT NULL,       -- Name der Pizza (maximal 255 Zeichen)
    preis NUMERIC(10, 2) NOT NULL,     -- Preis der Pizza mit maximal 10 Stellen, 2 Nachkommastellen
    bild TEXT                          -- URL oder Base64-String für das Bild der Pizza
);

INSERT INTO karte (pizza, preis, bild)
VALUES
('Margherita', 7.50, 'https://example.com/images/margherita.jpg'),
('Salami', 8.50, 'https://example.com/images/salami.jpg'),
('Hawaii', 9.00, 'https://example.com/images/hawaii.jpg');


-- Zutaten

CREATE TABLE zutaten (
    id SERIAL PRIMARY KEY,              -- Automatisch inkrementierende eindeutige ID
    zutat VARCHAR(255) NOT NULL,        -- Name der Zutat (maximal 255 Zeichen)
    preis NUMERIC(10, 2) NOT NULL,      -- Preis der Zutat mit maximal 10 Stellen, 2 Nachkommastellen
    anzahl INTEGER NOT NULL DEFAULT 0   -- Anzahl der verfügbaren Einheiten (Standardwert: 0)
);


INSERT INTO zutaten (zutat, preis, anzahl)
VALUES
('Zwiebel', 0.50, 100),
('Paprika', 0.80, 80),
('Oliven', 1.20, 70),
('Champignons', 1.00, 90),
('Knoblauch', 0.30, 60),
('Peperoni', 1.50, 50),
('Rucola', 0.70, 40),
('Ananas', 1.00, 30),
('Parmesan', 1.80, 20),
('Mozzarella', 2.50, 50);


-- Bestellungen

CREATE TABLE bestellungen (
    id SERIAL PRIMARY KEY,                 -- Automatisch inkrementierende eindeutige ID
    kunden_id INTEGER NOT NULL,            -- Verweis auf die ID des Kunden (z. B. aus einer Tabelle 'kunden')
    lieferadresse TEXT NOT NULL,           -- Lieferadresse des Kunden
    bestellung TEXT NOT NULL,              -- Details der Bestellung (z. B. JSON oder Beschreibung)
    gesamtpreis NUMERIC(10, 2) NOT NULL,   -- Gesamtpreis der Bestellung
    bestellt_am TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Zeitpunkt der Bestellung
    status VARCHAR(50) DEFAULT 'offen'     -- Status der Bestellung (z. B. offen, abgeschlossen, storniert)
);

INSERT INTO bestellungen (kunden_id, lieferadresse, bestellung, gesamtpreis, status)
VALUES
(1, 'Musterstraße 123, 12345 Musterstadt', '{"pizza": "Margherita", "extras": ["Oliven"]}', 12.50, 'offen'),
(2, 'Bahnhofstraße 5, 54321 Musterstadt', '{"pizza": "Salami", "extras": ["Knoblauch"]}', 10.50, 'abgeschlossen');


-- Kunden

CREATE TABLE kunden (
    id SERIAL PRIMARY KEY,               -- Automatisch inkrementierende eindeutige ID
    nachname VARCHAR(255) NOT NULL,      -- Nachname des Kunden
    vorname VARCHAR(255) NOT NULL,       -- Vorname des Kunden
    adresse TEXT NOT NULL,               -- Adresse des Kunden
    email VARCHAR(255) NOT NULL UNIQUE,  -- E-Mail-Adresse des Kunden (eindeutig)
    telefonnummer VARCHAR(20),           -- Telefonnummer des Kunden
    password VARCHAR(255) NOT NULL,      -- Passwort des Kunden (verschlüsselt)
    warenkorb TEXT                       -- Warenkorb des Kunden (z. B. als JSON-Format)
);


INSERT INTO kunden (nachname, vorname, adresse, email, telefonnummer, password, warenkorb)
VALUES
('Müller', 'Max', 'Musterstraße 123, 12345 Musterstadt', 'max.mueller@example.com', '0123456789', '$2b$10$k8sqD5P6E6eL.XcGV2TPNeX/58HhZdt2W3JXkfbYlQHPPFwW4JpW6', '[{"pizza": "Margherita", "anzahl": 2}]'),
('Schmidt', 'Anna', 'Bahnhofstraße 5, 54321 Beispielstadt', 'anna.schmidt@example.com', '0987654321', '$2b$10$PhEPMzfp6PaDwd1Fe5sBgOeKfB5Wuukd8UjZmVzKEMGJ3oaFgHRpO', '[{"pizza": "Salami", "anzahl": 3}]'),
('Weber', 'John', 'Parkallee 12, 11111 Hauptstadt', 'john.weber@example.com', '01701234567', '$2b$10$vNH6Ek8DYrcZYI4/vh.d7OZ/fK0MgfyJHDXm5/zLSNBQ4gnso21ei', '[{"pizza": "Hawaii", "anzahl": 1}]');
