<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.Cookie" %>

<%
    String action = request.getParameter("action");  // login or register
    String name = request.getParameter("name"); // Only for register
    String password = request.getParameter("password");
    String email = request.getParameter("email");  

    // DB credentials
    String dbURL = "jdbc:mysql://localhost:3306/lost_found";
    String dbUser = "root";
    String dbPass = "MO1325";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

    if ("register".equals(action)) {
        // Insert new user
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, password);  

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            Cookie userCookie = new Cookie("user", email);
            userCookie.setPath("/"); // Makes it valid across the entire app
            userCookie.setMaxAge(60 * 60 * 60);  
            response.addCookie(userCookie);
            response.sendRedirect("../pages/home.jsp");
        } else {
            out.println("<p>Registration failed.</p>");
        }
        stmt.close();

    } else if ("login".equals(action)) {
        // Check credentials
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // Valid user
            Cookie userCookie = new Cookie("user", email);
            userCookie.setPath("/"); // Makes it valid across the entire app
            userCookie.setMaxAge(60 * 60 * 60); 
            response.addCookie(userCookie);
            response.sendRedirect("../pages/home.jsp");
            // out.println("<p>Login successful. Welcome, " + name + "!</p>");

        } else {
            out.println("<p>Login failed. Invalid credentials.</p>");
        }
        rs.close();
        stmt.close();
    } else {
        out.println("<p>Invalid action.</p>");
    }

    conn.close();
%>
