CREATE TABLE zomato_data (
    url VARCHAR(1000),
    address VARCHAR(1000),
    name VARCHAR(500),
    online_order VARCHAR(50),
    book_table VARCHAR(50),
    rate VARCHAR(50),
    votes VARCHAR(100),
    phone VARCHAR(255),
    location VARCHAR(255),
    rest_type VARCHAR(255),
    dish_liked TEXT,
    cuisines VARCHAR(1000),
    approx_cost_for_two VARCHAR(500),
    reviews_list LONGTEXT,
    menu_item LONGTEXT,
    listed_in_type VARCHAR(255),
    listed_in_city VARCHAR(255),
    unnamed_17 VARCHAR(255),
    unnamed_18 VARCHAR(255),
    unnamed_19 VARCHAR(255)
);






-- -------------------------------Section A: Concept Application-------------------------------

-- 1. You are setting up a new database for the Zomato project. Which SQL
-- command creates a new database called analytics_db?

CREATE DATABASE analytics_db;

-- 2. You add a restaurant_id column to the restaurants table as its primary key.
-- What is a primary key, and why must its values be unique?

-- A primary key is a specific column that uniquely identifies 
-- each individual data in a database table. Its values must be unique to ensure 
-- that there is no issue when querying, updating, or linking specific rows. 
-- If duplicate primary keys were allowed, the database would not be able to distinguish one 
-- distinct restaurant from another.

-- 3. The ratings table references restaurant_id from the restaurants table. What is
-- a foreign key, and what integrity rule does it enforce?

-- A foreign key is a column in one table that links to the primary key of another table. 
-- It enforces referential integrity, which guarantees that the relationship between tables 
-- remains consistent. Specifically, it ensures that a record cannot be added to the child table 
-- if it references a non-existent parent record.

-- 4. You apply a NOT NULL constraint to the restaurant_name column. What kind of
-- data entry does this constraint prevent?

-- Applying a NOT NULL constraint to restaurant_name prevents the insertion of any record 
-- where the restaurant name is missing or left completely blank (NULL). 
-- It guarantees that every restaurant entry has a searchable, identifiable name.

-- 5. You draw an ER diagram before writing any SQL. What does an ER diagram
-- represent in relational database design?

-- An Entity-Relationship (ER) diagram is a structural blueprint that visualizes the 
-- database architecture before any code is written. It represents the entities 
-- (tables, like Restaurants or Locations), their attributes (columns, like IDs and Names), 
-- and the logical relationships (one-to-many, many-to-many) between them, 
-- ensuring the schema is properly normalized.


-- -------------------------------Section B: Practical Task-------------------------------

-- 1. Question no.1 in python file

-- 2. Implement SQL ALTER statements to establish Referential Integrity through
-- Foreign Key constraints between restaurants and locations with ON DELETЕ
-- CASCADE actions.

ALTER TABLE restaurants
ADD CONSTRAINT fk_restaurants_location
FOREIGN KEY (location_id) 
REFERENCES locations(location_id)
ON DELETE CASCADE;

-- 3. Question no.1 in python file


-- 4. Construct an optimized SQL indexing strategy on the location_id and cuisines
-- columns to accelerate multi-table JOIN operations for analytical queries.

CREATE INDEX idx_location_id ON restaurants(location_id);

CREATE INDEX idx_cuisines ON restaurants(cuisines);

CREATE INDEX idx_location_cuisines ON restaurants(location_id, cuisines);


-- -------------------------------Section c: Mini Project-------------------------------

-- project is in a different folder 

