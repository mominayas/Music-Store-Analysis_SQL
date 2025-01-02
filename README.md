# Music Store Data Analysis

This project analyzes a music store database to answer various business questions using PostgreSQL. The database includes information on employees, customers, invoices, tracks, artists, and more. The queries are designed to provide insights into customer behavior, sales trends, and performance metrics.

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Database Schema](#database-schema)
3. [Key Questions Answered](#key-questions-answered)
4. [SQL Queries](#sql-queries)
5. [How to Use](#how-to-use)
6. [Resources](#resources)

---

## Project Overview
This project involves querying the **Music Store** database to provide answers to critical business questions. It helps identify customer preferences, top-performing employees, and popular music genres to optimize business operations.

---

## Database Schema
- **Artist**
- **Album**
- **Track**
- **Genre**
- **MediaType**
- **Playlist** & **PlaylistTrack**
- **Customer**
- **Invoice** & **InvoiceLine**
- **Employee**

For a detailed look at the schema, see the included [MusicDatabaseSchema.png](./MusicDatabaseSchema.png).

---

## Key Questions Answered
### Set 1: Easy
1. **Who is the senior-most employee?**
2. **Which countries have the most invoices?**
3. **What are the top 3 invoice values?**
4. **Which city has the highest total invoice amount?**
5. **Who is the best customer based on total spending?**

### Set 2: Moderate
1. **Who are the Rock music listeners (with email, name, and genre)?**
2. **Which artists wrote the most Rock music?**
3. **Tracks longer than the average song length (sorted by length)?**

### Set 3: Advanced
1. **How much has each customer spent on artists (by customer and artist)?**
2. **What is the most popular music genre in each country?**
3. **Top customers by country and their total spending?**

---

## SQL Queries
The SQL queries used to answer these questions can be found in the script [Music_Store_database.sql](./Music_Store_database.sql). These queries are grouped by difficulty level and contain comments explaining the logic.

---

## How to Use
### Prerequisites
- PostgreSQL or any SQL-compatible tool.
- The provided [Music Store Database](./Music_Store_database.sql) loaded into your SQL environment.

## Resources
- [Full Project Video](https://youtu.be/VFIuIjswMKM?si=h18aPchfqf-yzF2Z)

