# SQL SCHEMA

``` sql
CREATE DATABASE lost_found;

USE lost_found;

CREATE TABLE users (
  name VARCHAR(50) UNIQUE,
  email VARCHAR(100) PRIMARY KEY,
  password VARCHAR(100),
  role ENUM('admin', 'user') DEFAULT 'user'
);

CREATE TABLE items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255),  -- Must exist to reference it
  name VARCHAR(100),
  description TEXT,
  type ENUM('lost', 'found'),
  location VARCHAR(100),
  date DATE,
  FOREIGN KEY (email) REFERENCES users(email)
);
```
