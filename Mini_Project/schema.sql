CREATE DATABASE IF NOT EXISTS food_tech_analytics;
USE food_tech_analytics;

CREATE TABLE locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(255) NOT NULL,
    listed_in_city VARCHAR(255),
    UNIQUE(location_name, listed_in_city)
);

CREATE TABLE cuisines (
    cuisine_id INT AUTO_INCREMENT PRIMARY KEY,
    cuisine_name VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(1000),
    phone VARCHAR(255),
    online_order BOOLEAN DEFAULT FALSE,
    book_table BOOLEAN DEFAULT FALSE,
    approx_cost_for_two INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    rate FLOAT,
    votes INT DEFAULT 0,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

CREATE TABLE restaurant_cuisines (
    restaurant_id INT,
    cuisine_id INT,
    PRIMARY KEY (restaurant_id, cuisine_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    FOREIGN KEY (cuisine_id) REFERENCES cuisines(cuisine_id) ON DELETE CASCADE
);

CREATE INDEX idx_restaurant_location ON restaurants(location_id);
CREATE INDEX idx_ratings_rate ON ratings(rate);