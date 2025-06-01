# Lost and Found Portal

A simple web-based Lost and Found portal built with JSP, Servlets, JDBC, and MySQL.  
Users can report lost/found items, browse listings, and contact item owners.

## Features

- User login via cookie-based session  
- Report lost or found items with description, date, and location  
- View all reported items in card layout  
- View your active listings  
- Simple and responsive UI with Bootstrap  
- Admin panel (optional) to manage listings (if implemented)  

---

## Technology Stack

- Java JSP & Servlets  
- MySQL Database  
- JDBC for database connectivity  
- Apache Tomcat as the web server  
- Bootstrap 5 for frontend styling  
- Cookies for user session management  

---

## Database Schema (MySQL)

```sql
CREATE DATABASE lost_found;

USE lost_found;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Items table
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    type ENUM('Lost', 'Found') NOT NULL,
    location VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    FOREIGN KEY (email) REFERENCES users(email) ON DELETE CASCADE
);
````

---

## Project Structure

``` md
LostAndFoundPortal/
│├── index.html               # Login or landing page
│├──  pages/
|      └── home.jsp 
|      └── pages/ 
│           ├── dashboard.jsp            # Display lost and found summary
│           ├── allitems.jsp             # Display lost and found items (card layout)
│           ├── report.jsp               # Form to report lost/found item
│           ├── myListings.jsp           # User’s own items
│           ├── settings.jsp             # User settings page
│           ├── logout.jsp             # User logout logic
│└── utils/
│     └── itemInsert.jsp       # Backend logic to insert items
|     └── Auth.jsp       # Backend logic to Authenticate User
│── lib/                  # Any libraries (JAR files)
│   └──   mysql-connector-j-9.3.0.jar
└── README.md                    # This file
```

---

## How to Setup and Run

### 1. Setup MySQL Database

- Install MySQL if not installed
- Run the above SQL commands to create the database and tables
- Optionally, insert some test users:

```sql
INSERT INTO users (name, email, password) VALUES ('Test User', 'test@example.com', 'test123');
```

### 2. Configure Database Connection

- Update database URL, username, and password in JSP files connecting to DB, for example:

```java
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "your_mysql_password");
```

### 3. Setup Apache Tomcat

- Download and install Apache Tomcat ([https://tomcat.apache.org/](https://tomcat.apache.org/))
- Place the project folder inside `webapps` directory of Tomcat (or deploy WAR file)
- Start Tomcat server (`bin/startup.sh` or `startup.bat`)

### 4. Access the Application

- Open browser and go to:
  `http://localhost:8080/LostAndFoundPortal/index.html`
- Login with your test user or register your own user
- Use the portal to report items, view listings, etc.

---

## Additional Notes

- The project currently uses cookies for session tracking.
- Password storage in this example is plain text (not secure). For production, use hashing!
- You can enhance with user registration, authentication, and admin features.
- UI uses Bootstrap CDN for styling, no local CSS required.
- For better security, use prepared statements as shown to prevent SQL injection.

---

## License

This project is open-source and free to use.
