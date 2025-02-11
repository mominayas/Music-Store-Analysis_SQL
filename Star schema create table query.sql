
-- 1️⃣ Create Dimension Tables

DROP TABLE IF EXISTS Dim_Customer CASCADE;
CREATE TABLE Dim_Customer AS
SELECT customer_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email, support_rep_id
FROM customer;

DROP TABLE IF EXISTS Dim_Employee CASCADE;
CREATE TABLE Dim_Employee AS
SELECT employee_id, last_name, first_name, title, reports_to, birthdate, hire_date, address, city, state, country, postal_code, phone, fax, email
FROM employee;

DROP TABLE IF EXISTS Dim_Track CASCADE
CREATE TABLE Dim_Track AS
SELECT track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price
FROM track;

DROP TABLE IF EXISTS Dim_Album CASCADE
CREATE TABLE Dim_Album AS
SELECT album_id, title, artist_id
FROM album;

DROP TABLE IF EXISTS Dim_Artist CASCADE
CREATE TABLE Dim_Artist AS
SELECT artist_id, name
FROM artist;

DROP TABLE IF EXISTS Dim_Genre CASCADE
CREATE TABLE Dim_Genre AS
SELECT genre_id, name
FROM genre;

DROP TABLE IF EXISTS Dim_MediaType CASCADE
CREATE TABLE Dim_MediaType AS
SELECT media_type_id, name
FROM media_type;

DROP TABLE IF EXISTS Dim_Invoice CASCADE
CREATE TABLE Dim_Invoice AS
SELECT invoice_id, customer_id, invoice_date, billing_address, billing_city, billing_state, billing_country, billing_postal, total
FROM invoice;


-- 2️⃣ Create Fact Table
DROP TABLE IF EXISTS Fact_Sales CASCADE
CREATE TABLE Fact_Sales AS
SELECT 
    il.invoice_line_id, 
    i.invoice_id, 
    i.customer_id, 
    c.support_rep_id AS employee_id, 
    il.track_id, 
    il.unit_price, 
    il.quantity, 
    (il.unit_price * il.quantity) AS total
FROM invoice_line il
JOIN invoice i ON il.invoice_id = i.invoice_id
JOIN customer c ON i.customer_id = c.customer_id;


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name IN ('dim_employee', 'fact_sales') 
AND column_name = 'employee_id';

ALTER TABLE Dim_Employee ALTER COLUMN employee_id TYPE INTEGER USING employee_id::INTEGER;


ALTER TABLE Dim_Customer ADD PRIMARY KEY (customer_id);
ALTER TABLE Dim_Employee ADD PRIMARY KEY (employee_id);
ALTER TABLE Dim_Track ADD PRIMARY KEY (track_id);
ALTER TABLE Dim_Album ADD PRIMARY KEY (album_id);
ALTER TABLE Dim_Artist ADD PRIMARY KEY (artist_id);
ALTER TABLE Dim_Genre ADD PRIMARY KEY (genre_id);
ALTER TABLE Dim_MediaType ADD PRIMARY KEY (media_type_id);
ALTER TABLE Dim_Invoice ADD PRIMARY KEY (invoice_id);


ALTER TABLE Fact_Sales ADD PRIMARY KEY (invoice_line_id);

ALTER TABLE Fact_Sales ADD CONSTRAINT fk_invoice FOREIGN KEY (invoice_id) REFERENCES Dim_Invoice(invoice_id);
ALTER TABLE Fact_Sales ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id);
ALTER TABLE Fact_Sales ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES Dim_Employee(employee_id);
ALTER TABLE Fact_Sales ADD CONSTRAINT fk_track FOREIGN KEY (track_id) REFERENCES Dim_Track(track_id);


SELECT 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_name AS foreign_table, 
    ccu.column_name AS foreign_column
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu 
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu 
    ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY';


