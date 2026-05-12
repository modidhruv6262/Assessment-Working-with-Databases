# 🍽️ Predictive Demand Schema Architecture for Food-Tech Analytics

## 📌 Project Overview
This project focuses on designing and implementing a normalized, high-performance relational database architecture optimized for machine learning pipelines. By transforming flat, unstructured food-tech data (Zomato) into a Third Normal Form (3NF) relational model, this architecture accelerates real-time feature extraction for restaurant success prediction models.

## 🎯 Problem Statement
Machine learning models require highly structured, aggregated, and optimized data features. Querying flat CSV files or denormalized databases for real-time demand scoring leads to data anomalies and slow analytical joins. This project solves this by decomposing flat data into a robust fact-dimension architecture, enabling rapid calculation of complex ML features like neighborhood competition indices and weighted demand scores.

## ⚙️ Tech Stack
* **Language:** Python 3.x
* **Data Processing:** Pandas, NumPy
* **Database & ORM:** MySQL, SQLAlchemy
* **Query Language:** Advanced SQL (Window Functions, CTEs, Aggregations)
* **Architecture:** 3NF Relational Data Modeling

## 📂 Key Deliverables
1. **Python Data Ingestion Pipeline (`main.py`):** An automated ETL script that cleans string irregularities (e.g., parsing ratings and costs), maps boolean values, and ingests data into the relational schema while preserving referential integrity.
2. **Optimized DDL Script (`schema.sql`):** The SQL definitions for the 3NF schema, including primary/foreign key constraints, `ON DELETE CASCADE` actions, and optimized indexes (`B-Tree`) for frequent multi-table joins.
3. **Entity-Relationship Architecture:** A logically structured relational model separating `Locations`, `Restaurants` (Core Entity), `Ratings` (Fact), and `Cuisines`.
4. **Feature Engineering Report (`SQL Feature Engineering Report.sql`):** An advanced SQL query designed to feed an ML backend. It generates predictive features such as:
   * Digital Readiness Score
   * Weighted Demand Score
   * Neighborhood Competition Index
   * Local Price Variance

