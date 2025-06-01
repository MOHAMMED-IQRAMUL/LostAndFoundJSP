<%@ page import="java.sql.*, jakarta.servlet.http.Cookie" %>

<%
    // Get user from cookie
    String email = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("user".equals(cookie.getName())) {
                email = cookie.getValue();
                break;
            }
        }
    }

    boolean isValidUser = false;
    String name = "";

    if (email != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "MO1325");

            String sql = "SELECT name FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                isValidUser = true;
                name = rs.getString("name");
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("Database error: " + e.getMessage());
        }
    }

    if (!isValidUser) {
%>
    <script>
        alert("Please log in to access the dashboard.");
        window.location.href = "../index.html";
    </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f4f6f9;
    }
    .card-stat {
      border-left: 5px solid #0d6efd;
    }
    .badge {
      font-size: 0.9rem;
    }
  </style>
</head>
<body>

<div class="container my-4">

  <!-- Greeting -->
  <div class="mb-4">
    <h3>Welcome, <%= name %>!</h3>
    <p class="text-muted">Here is a summary of your lost and found reports.</p>
  </div>

  <!-- Summary Cards -->
  <div class="row text-center mb-4">
    <%
      int lostCount = 0, foundCount = 0, returnedCount = 0;
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "MO1325");

          Statement stat = conn.createStatement();
          ResultSet rs1 = stat.executeQuery("SELECT COUNT(*) FROM items WHERE type = 'lost'");
          if (rs1.next()) lostCount = rs1.getInt(1);

          ResultSet rs2 = stat.executeQuery("SELECT COUNT(*) FROM items WHERE type = 'found'");
          if (rs2.next()) foundCount = rs2.getInt(1);

          conn.close();
      } catch (Exception e) {
          out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
      }
    %>
    <div class="col-md-4">
      <div class="card card-stat shadow-sm mb-3">
        <div class="card-body">
          <h5>Total Lost</h5>
          <p class="display-6"><%= lostCount %></p>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card card-stat shadow-sm mb-3">
        <div class="card-body">
          <h5>Total Found</h5>
          <p class="display-6"><%= foundCount %></p>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card card-stat shadow-sm mb-3 border-success">
        <div class="card-body">
          <h5>Items Returned</h5>
          <p class="display-6">2</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Overview List -->
  <h5 class="mb-3">Recent Activity</h5>
  <div class="list-group">
    <%
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "MO1325");

          String sql = "SELECT name, location, date, type FROM items ORDER BY date DESC LIMIT 6";
          PreparedStatement stmt = conn.prepareStatement(sql);
          ResultSet rs = stmt.executeQuery();

          while (rs.next()) {
              String itemName = rs.getString("name");
              String location = rs.getString("location");
              String date = rs.getString("date");
              String type = rs.getString("type");

              String badge = "danger";
              String label = "Lost";
              if ("found".equals(type)) {
                  badge = "success";
                  label = "Found";
              }
    %>
      <div class="list-group-item">
        <strong><%= itemName %></strong> - <%= label %> near <%= location %> on <%= date %>
        <span class="badge bg-<%= badge %> float-end"><%= label %></span>
      </div>
    <%
          }
          conn.close();
      } catch (Exception e) {
          out.println("<div class='text-danger'>Error loading items: " + e.getMessage() + "</div>");
      }
    %>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
